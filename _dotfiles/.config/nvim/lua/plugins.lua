local function install_packages()
	vim.pack.add({
		-- syntax files and LSP defaults
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/neovim/nvim-lspconfig",

		-- quick move/find, smart autocomplete, colorscheme, etc.
		"https://codeberg.org/andyg/leap.nvim",
		"https://github.com/HoNamDuong/hybrid.nvim",
		"https://github.com/airblade/vim-gitgutter",
		"https://github.com/ervandew/supertab",
		"https://github.com/ibhagwan/fzf-lua",
	})
end

local function configure_before()
	-- supertab
	vim.g.SuperTabDefaultCompletionType = "context"
end

local function configure_after()
	-- leap
	local leap = require("leap")
	leap.opts.vim_opts["go.ignorecase"] = true
	vim.keymap.set("n", "<leader> ", "<Plug>(leap)")

	-- fzf
	vim.keymap.set("n", "<leader>b", "<Esc>:FzfLua buffers<Enter>")
	vim.keymap.set("n", "<leader>ff", "<Esc>:FzfLua files<Enter>")
	vim.keymap.set("n", "<leader>ls", "<Esc>:FzfLua lsp_document_symbols<Enter>")
end

return {
	install_and_configure = function()
		configure_before()
		install_packages()
		configure_after()
	end,
}
