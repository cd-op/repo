vim.g.mapleader = " "
vim.g.maplocalleader = " "

local utils = require("utils")
utils.missing_progs("fzf", "tree-sitter")

require("plugins").install_and_configure()
require("statusline").configure()

-- text/code options
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.cmd.filetype({ args = { "plugin", "indent", "on" } })
vim.cmd.syntax("on")

-- color/UI options
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = "tab:↦ ,trail:·"
vim.opt.colorcolumn = "79,80,99,100,119,120"
vim.opt.termguicolors = true
vim.cmd.colorscheme("hybrid")

-- cmd/menu options (wild mode behaves like bash)
vim.opt.cmdheight = 0
vim.opt.wildmode = "longest,list"
vim.opt.wildmenu = true

local imap = utils.imap
local nmap = utils.nmap

nmap("<Leader>slen", "<Esc>:set spell spelllang=en<Return>")
nmap("<Leader>slpt", "<Esc>:set spell spelllang=pt<Return>")
nmap("<Leader>sl0", "<Esc>:set nospell<Return>")

nmap("<Leader>1", "<Esc>:b 1<Return>")
nmap("<Leader>2", "<Esc>:b 2<Return>")
nmap("<Leader>3", "<Esc>:b 3<Return>")
nmap("<Leader>4", "<Esc>:b 4<Return>")

nmap("<Up>", "")
nmap("<Down>", "")
nmap("<Left>", "")
nmap("<Right>", "")

imap([["]], [[""<Esc>]])
imap([[']], [[''<Esc>]])
imap("(", "()<Esc>")
imap("{", "{}<Esc>")
imap("[", "[]<Esc>")
