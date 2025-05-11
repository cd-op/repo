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

imap([["]], [[""<Esc>]])
imap([[']], [[''<Esc>]])
imap("(", "()<Esc>")
imap("{", "{}<Esc>")
imap("[", "[]<Esc>")

for _, x in ipairs({
	{
		"dtz",
		[[<Esc>mz:read !date --utc +"\%FT\%R:\%SZ"|tr -d "\n"<Return>d$`zpea]],
	},
}) do
	cmd.inoreabbrev({ args = x })
end

-- mkdir -p .local/share/nvim/pckr
-- cd .local/share/nvim/pckr
-- git clone filter=blob:none https://github.com/lewis6991/pckr.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/pckr/pckr.nvim")
require("pckr").add({
	-- ui
	{
		"HoNamDuong/hybrid.nvim",
		config = function()
			cmd.colorscheme("hybrid")
		end,
	},
	-- {
	-- 	"sainnhe/sonokai",
	-- 	config = function()
	-- 		g.sonokai_style = "default"
	-- 		g.sonokai_better_performance = 1
	-- 		g.sonokai_colors_override = {
	-- 			bg_dim = { "#232323", "233" },
	-- 			bg0 = { "#2e2e2e", "234" },
	-- 			bg1 = { "#353535", "235" },
	-- 			bg2 = { "#393939", "236" },
	-- 			bg3 = { "#3e3e3e", "237" },
	-- 			bg4 = { "#454545", "237" },
	-- 			grey = { "#848484", "246" },
	-- 			grey_dim = { "#5f5f5f", "240" },
	-- 		}
	-- 		cmd.colorscheme("sonokai")
	-- 	end,
	-- },

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

	-- markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
})
