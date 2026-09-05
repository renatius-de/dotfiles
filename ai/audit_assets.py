#!/usr/bin/env python3
"""Audit repository-managed AI instruction and skill Markdown files."""

from __future__ import annotations

import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parent
REPORT = ROOT / "audit_report.md"
ASSET_PATTERNS = ("instructions/*.instructions.md", "skills/**/SKILL.md")
FRONTMATTER_FIELDS = {"name", "description", "applyTo"}
RISK_PATTERNS = {
    "secret-like example": re.compile(r"(?i)(password|api[_ -]?key|access[_ -]?token)\s*[:=]\s*[^`\s]+"),
    "unsafe TLS guidance": re.compile(r"(?i)(disable|skip|ignore).*tls|trust.?all|verify\s*=\s*false"),
    "stack-trace exposure": re.compile(r"(?i)(expose|return|leak).*stack trace"),
}


def asset_files() -> list[Path]:
    files = {path for pattern in ASSET_PATTERNS for path in ROOT.glob(pattern)}
    return sorted(files)


def parse_frontmatter(text: str) -> tuple[dict[str, str], list[str]]:
    if not text.startswith("---\n"):
        return {}, ["missing YAML frontmatter"]
    closing = text.find("\n---", 4)
    if closing < 0:
        return {}, ["unterminated YAML frontmatter"]
    metadata: dict[str, str] = {}
    errors: list[str] = []
    for line_number, line in enumerate(text[4:closing].splitlines(), start=2):
        if not line.strip():
            continue
        match = re.fullmatch(r"([A-Za-z][A-Za-z0-9_-]*):\s*(.*)", line)
        if not match:
            errors.append(f"invalid frontmatter line {line_number}: {line}")
            continue
        metadata[match.group(1)] = match.group(2).strip().strip('"')
    return metadata, errors


def markdown_checks(path: Path, text: str) -> list[str]:
    findings: list[str] = []
    fences = re.findall(r"^\s*(```+|~~~+)", text, re.MULTILINE)
    if len(fences) % 2:
        findings.append("unbalanced fenced code block")
    headings = re.findall(r"^(#{1,6})\s+(.+?)\s*$", text, re.MULTILINE)
    if not headings:
        findings.append("no Markdown heading")
    if re.search(r"^#{1,6}[^ #]", text, re.MULTILINE):
        findings.append("heading marker is not followed by a space")
    for target in re.findall(r"\[[^]]+\]\(([^)#]+)(?:#[^)]+)?\)", text):
        if target.startswith(("http://", "https://", "mailto:")):
            continue
        if not (path.parent / target).exists() and not (ROOT / target).exists():
            findings.append(f"broken relative link: {target}")
    return findings


def code_block_checks(text: str) -> list[str]:
    findings: list[str] = []
    for match in re.finditer(r"```(yaml|yml|json|bash|sh|shell|makefile)?\n(.*?)```", text, re.DOTALL | re.IGNORECASE):
        language = (match.group(1) or "").lower()
        body = match.group(2)
        if language in {"json"}:
            try:
                json.loads(body)
            except json.JSONDecodeError as error:
                findings.append(f"invalid JSON code block: {error.msg}")
        if language in {"yaml", "yml"} and re.search(r"\t", body):
            findings.append("YAML code block contains tabs")
    return findings


def metadata_checks(path: Path, metadata: dict[str, str], errors: list[str]) -> list[str]:
    findings = list(errors)
    is_instruction = path.name.endswith(".instructions.md")
    expected_name = path.name.removesuffix(".instructions.md") if is_instruction else path.parent.name
    required_fields = FRONTMATTER_FIELDS if is_instruction else {"name", "description"}
    missing = required_fields - metadata.keys()
    findings.extend(f"missing frontmatter field: {field}" for field in sorted(missing))
    if metadata.get("name") and metadata["name"] != expected_name:
        findings.append(f"frontmatter name does not match filename: {metadata['name']}")
    if is_instruction and metadata.get("applyTo") == "**":
        findings.append("broad applyTo pattern applies to the entire repository")
    if not is_instruction and path.name != "SKILL.md":
        findings.append("skill filename is not SKILL.md")
    return findings


def security_checks(text: str) -> list[str]:
    findings = []
    for label, pattern in RISK_PATTERNS.items():
        match = pattern.search(text)
        if match:
            context = text[max(0, match.start() - 40):match.start()].lower()
            if re.search(r"(?:do not|don't|never|avoid|without)\s*$", context):
                continue
            findings.append(label)
    if re.search(r"(?i)security|oauth|csrf|tls|secret|credential|token", text) and not re.search(
        r"(?i)do not|never|avoid|validate|protect|least privilege|without exposing", text
    ):
        findings.append("security-sensitive topic lacks an explicit protective rule")
    return findings


def normalized_bullets(text: str) -> Counter[str]:
    prose = re.sub(r"```.*?```", "", text, flags=re.DOTALL)
    bullets = re.findall(r"^\s*[-*]\s+(.+?)\s*$", prose, re.MULTILINE)
    return Counter(re.sub(r"[`*_]", "", bullet).strip().lower() for bullet in bullets)


def run() -> int:
    files = asset_files()
    findings: dict[str, list[str]] = {}
    metadata_by_file: dict[str, dict[str, str]] = {}
    bullet_sources: defaultdict[str, list[str]] = defaultdict(list)

    for path in files:
        text = path.read_text(encoding="utf-8")
        metadata, frontmatter_errors = parse_frontmatter(text)
        relative = path.relative_to(ROOT.parent).as_posix()
        metadata_by_file[relative] = metadata
        current = []
        current.extend(metadata_checks(path, metadata, frontmatter_errors))
        current.extend(markdown_checks(path, text))
        current.extend(code_block_checks(text))
        current.extend(security_checks(text))
        findings[relative] = current
        for bullet, count in normalized_bullets(text).items():
            if count > 0:
                bullet_sources[bullet].append(relative)

    duplicates = {bullet: sources for bullet, sources in bullet_sources.items() if len(sources) > 1}
    naming_errors = []
    for relative in metadata_by_file:
        path = Path(relative)
        if path.name.endswith(".instructions.md") and not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*\.instructions\.md", path.name):
            naming_errors.append(f"non-kebab-case instruction filename: {relative}")
        if path.name == "SKILL.md" and not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", path.parent.name):
            naming_errors.append(f"non-kebab-case skill directory: {relative}")

    report_lines = [
        "# AI Asset Audit Report",
        "",
        f"Generated by `ai/audit_assets.py` for {len(files)} instruction and skill files.",
        "",
        "## Summary",
        "",
        f"- Files audited: {len(files)}",
        f"- Files with findings: {sum(bool(items) for items in findings.values())}",
        f"- File-level findings: {sum(len(items) for items in findings.values())}",
        f"- Cross-file duplicate bullet rules: {len(duplicates)}",
        f"- Naming findings: {len(naming_errors)}",
        "",
        "Severity is qualitative: syntax and broken references are errors; missing metadata, broad scope, duplication, and security hardening gaps are warnings or optimization suggestions.",
        "",
        "## Automated Checks",
        "",
        "- Markdown: heading presence, heading spacing, balanced fenced code blocks, and relative-link existence.",
        "- Frontmatter: delimiter presence, simple YAML key/value shape, required instruction fields, and filename alignment.",
        "- Code blocks: JSON parsing and YAML tab detection where language tags are present.",
        "- Consistency: kebab-case paths and duplicate normalized bullet rules across files.",
        "- Security: secret-like examples, unsafe TLS instructions, stack-trace exposure, and missing protective language around security topics.",
        "",
        "## File Findings",
        "",
    ]
    for relative in sorted(findings):
        items = findings[relative]
        report_lines.append(f"### `{relative}`")
        if items:
            report_lines.extend(f"- **Warning:** {item}" for item in items)
        else:
            report_lines.append("- No automated findings.")
        report_lines.append("")

    report_lines.extend(["## Cross-File Findings", ""])
    if naming_errors:
        report_lines.append("### Naming")
        report_lines.extend(f"- **Warning:** {item}" for item in naming_errors)
        report_lines.append("")
    if duplicates:
        report_lines.append("### Redundancy")
        for bullet, sources in sorted(duplicates.items()):
            report_lines.append(f"- **Optimization:** The normalized rule `{bullet}` appears in {', '.join(f'`{source}`' for source in sources)}.")
        report_lines.append("")
    if not naming_errors and not duplicates:
        report_lines.append("- No cross-file naming or exact bullet duplication findings.")
        report_lines.append("")

    report_lines.extend([
        "## Manual Review Recommendations",
        "",
        "- Add consistent frontmatter to `SKILL.md` files if the consuming agent tooling supports and requires it; otherwise document the intentional distinction between instruction metadata and skill metadata.",
        "- Review repeated Java and OpenAPI guidance for a single source of truth. The two OpenAPI assets intentionally overlap, but their OpenAPI 3.0 versus 3.2 scope should remain explicit.",
        "- Confirm that version-specific recommendations such as Java 25, JUnit 6, Spring Boot 4, and OASDiff Docker are supported by the repositories that consume these assets.",
        "- Keep generated audit output separate from the asset source files and rerun the script after future changes.",
        "",
        "## Limitations",
        "",
        "- This audit does not prove full CommonMark compliance, execute embedded shell commands, compile Java examples, validate arbitrary YAML without an external YAML parser, or run OASDiff against a real OpenAPI document.",
        "- Semantic contradiction detection is heuristic. Human review is still required for precedence, version compatibility, and domain-specific security guidance.",
    ])
    REPORT.write_text("\n".join(report_lines) + "\n", encoding="utf-8")
    print(f"Audited {len(files)} files; wrote {REPORT}")
    return 0


if __name__ == "__main__":
    sys.exit(run())