vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])
vim.cmd([[colorscheme evening]])

local opt = vim.opt
opt.background = "dark"
opt.backspace = "indent,eol,start"
opt.backup = false
opt.cindent = true
opt.clipboard = "unnamedplus"
opt.cmdwinheight = 5
opt.colorcolumn = "+1"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true
opt.cursorcolumn = true
opt.cursorline = true
opt.dictionary:append("/usr/share/dict/words")
opt.diffopt = "filler,context:3,vertical,foldcolumn:3"
opt.display:append("lastline")
opt.encoding = "utf-8"
opt.expandtab = true
opt.helpheight = 0
opt.helplang = { "en", "de" }
opt.hlsearch = false
opt.incsearch = true
opt.joinspaces = false
opt.laststatus = 2
opt.lazyredraw = true
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.path:append("**")
opt.previewheight = 5
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.shiftround = true
opt.shiftwidth = 4
opt.showmatch = true
opt.showtabline = 2
opt.shortmess:append("c")
opt.signcolumn = "yes"
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 4
opt.spellsuggest = { "best", 10 }
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.termguicolors = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undofile = true
opt.visualbell = true
opt.writebackup = false

if vim.fn.has("spell") == 1 then
  opt.spelllang = { "de_de", "de", "en_gb", "en_us", "en" }
end
