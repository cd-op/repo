local cmd, g, o = vim.cmd, vim.g, vim.o

-- text/code options
o.hidden = true
o.swapfile = false
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
cmd.filetype({ args = { "plugin", "indent", "on" } })
cmd.syntax("on")

-- color/UI options
o.splitbelow = true
o.splitright = true
o.background = "dark"
o.number = true
o.list = true
o.listchars = "tab:↦ ,trail:·"
o.colorcolumn = "79,80,99,100,119,120"
o.termguicolors = true
cmd.colorscheme("monokai_pro")

-- menu options (wild mode behaves like bash)
o.wildmode = "longest,list"
o.wildmenu = true

-- globals
g.mapleader = ","
g.maplocalleader = ","

-- key bindings
local function imap(l, r)
	vim.keymap.set("i", l, r .. "i", { noremap = true })
end

local function nmap(l, r)
	vim.keymap.set("n", l, r, { noremap = true })
end

local function inmap(l, r)
	imap(l, r)
	nmap(l, r)
end

inmap("<C-Left>", "<Esc>:bprev<Return>")
inmap("<C-Right>", "<Esc>:bnext<Return>")
inmap("<C-Space>", "<Esc>:FZF<Return>")
inmap("<C-LeftMouse>", "<Esc>:ALEGoToDefinition<Return>")
inmap("<F1>", "<Esc>:TagbarToggle<Return>")

nmap("<Leader>slen", "<Esc>:set spell spelllang=en<Return>")
nmap("<Leader>slpt", "<Esc>:set spell spelllang=pt<Return>")
nmap("<Leader>sl0", "<Esc>:set nospell<Return>")

nmap("<Up>", "")
nmap("<Down>", "")
nmap("<Left>", "")
nmap("<Right>", "")

-- mkdir -p .local/share/nvim/pckr
-- cd .local/share/nvim/pckr
-- git clone filter=blob:none https://github.com/lewis6991/pckr.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/pckr/pckr.nvim")
require("pckr").add({
	-- ui
	"erichain/vim-monokai-pro",

	{
		"ervandew/supertab",
		config_pre = function()
			g.SuperTabDefaultCompletionType = "context"
		end,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			nmap("s", "<Plug>(leap)")
		end,
	},

	"junegunn/fzf",

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

	"vim-airline/vim-airline-themes",

	{
		"vim-airline/vim-airline",
		config_pre = function()
			g.airline_theme = "minimalist"
			g["airline#extensions#tabline#enabled"] = 1
		end,
	},

	-- code
	"airblade/vim-gitgutter",

	{
		"dense-analysis/ale",
		config_pre = function()
			g.ale_completion_enabled = 1
			g.ale_fix_on_save = 1
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").gopls.setup({ settings = { gopls = { gofumpt = true } } })
		end,
	},

	"nvim-treesitter/nvim-treesitter",
	"preservim/tagbar",

	-- orgmode
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/x/plans/notes.orgmode.d/**/*",
				org_default_notes_file = "~/x/plans/notes.orgmode.d/inboxes/desktop.org",
			})
		end,
	},
})
