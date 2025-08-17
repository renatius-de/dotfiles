# Antigen-Setup mit gebündelten, gut strukturierten Bundles

# Konstanten/Defaults
typeset -gr ANTIGEN_DEFAULT_FILE="/opt/homebrew/share/antigen/antigen.zsh"
typeset -gr ANTIGEN_THEME="candy"

# Arrays (global, read-only)
typeset -gra ANTIGEN_COMMON_BUNDLES=(
  history-substring-search
  jenv
  themes
  vi-mode
)
typeset -gra ANTIGEN_DARWIN_BUNDLES=(
  brew
  macos
)
typeset -gra ANTIGEN_EXTRA_BUNDLES=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
)

# Anwender-Override ermöglichen
ANTIGEN_FILE="${ANTIGEN_FILE:-$ANTIGEN_DEFAULT_FILE}"

if [[ -r "$ANTIGEN_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ANTIGEN_FILE"

  antigen use oh-my-zsh

  # Helferfunktion: klarer Name + zentrierte Bundle-Ladelogik
  antigen_load_bundles() {
    local bundle
    for bundle in "$@"; do
      antigen bundle "$bundle"
    done
  }

  # Gemeinsame Bundles laden
  antigen_load_bundles "${ANTIGEN_COMMON_BUNDLES[@]}"

  # OS-spezifische Bundles und Variablen
  if [[ "$(uname -s)" == "Darwin" ]]; then
    antigen_load_bundles "${ANTIGEN_DARWIN_BUNDLES[@]}"
    export HOMEBREW_NO_ENV_HINTS=1
  fi

  # Zusätzliche Bundles und Theme anwenden
  antigen_load_bundles "${ANTIGEN_EXTRA_BUNDLES[@]}"
  antigen theme "$ANTIGEN_THEME"
  antigen apply
fi
