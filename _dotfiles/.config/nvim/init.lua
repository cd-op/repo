-- text/code options
vim.o.hidden = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd[[filetype indent plugin on]]
vim.cmd[[syntax on]]

-- color/UI options
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.background = "dark"
vim.o.number = true
vim.o.list = true
vim.o.listchars = "tab:↦ ,trail:·"
vim.o.colorcolumn = "79,80"
vim.o.termguicolors = true
vim.cmd[[colorscheme monokai_pro]]

-- menu options (wild mode behaves like bash)
vim.o.wildmode = "longest,list"
vim.o.wildmenu = true

-- todo: double check these
-- mouse/paste options
-- vim.o.mouse = "a"
-- set paste
-- set clipboard=unnamedplus
-- set spell spelllang=en

-- variables
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- mappings
vim.cmd[[
inoremap <C-Left> <Esc>:bprev<Return>i
nnoremap <C-Left> <Esc>:bprev<Return>
inoremap <C-Right> <Esc>:bnext<Return>i
nnoremap <C-Right> <Esc>:bnext<Return>

inoremap <C-Space> <Esc>:FZF<Return>i
nnoremap <C-Space> <Esc>:FZF<Return>

inoremap <C-LeftMouse> <Esc>:ALEGoToDefinition<Return>i
nnoremap <C-LeftMouse> <Esc>:ALEGoToDefinition<Return>

inoremap <F1> <Esc>:TagbarToggle<Return>i
nnoremap <F1> <Esc>:TagbarToggle<Return>

inoremap <F10> <Esc>:set spell spelllang=pt<Return>i
nnoremap <F10> <Esc>:set spell spelllang=pt<Return>
inoremap <F11> <Esc>:set spell spelllang=en<Return>i
nnoremap <F11> <Esc>:set spell spelllang=en<Return>
inoremap <F12> <Esc>:set nospell<Return>i
nnoremap <F12> <Esc>:set nospell<Return>
]]

-- pckr bootstrap and plugins
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- ui
  'erichain/vim-monokai-pro',

  {'ervandew/supertab', config_pre = function ()
    vim.g.SuperTabDefaultCompletionType = "context"
  end},

  'junegunn/fzf',

  {"stevearc/oil.nvim", config = function()
      require("oil").setup()
  end},

  'vim-airline/vim-airline-themes',

  {'vim-airline/vim-airline', config_pre = function ()
    vim.g.airline_theme = 'minimalist'
    vim.g['airline#extensions#tabline#enabled'] = 1
  end},

  -- code
  'airblade/vim-gitgutter',

  {'dense-analysis/ale', config_pre = function ()
    vim.g.ale_completion_enabled = 1
    vim.g.ale_fix_on_save = 1
  end},

  {'numToStr/Comment.nvim', config = function()
        require('Comment').setup()
  end},

  'nvim-treesitter/nvim-treesitter',
  'preservim/tagbar',

  -- orgmode
  { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup({
      org_agenda_files = '~/x/plans/notes.orgmode.d/**/*',
      org_default_notes_file = '~/x/plans/notes.orgmode.d/inbox-desktop.org',
    })
  end}
}
