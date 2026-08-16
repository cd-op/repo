local utils = require("utils")

if utils.missing_progs("lua-language-server", "stylua") then
	return
end

require("nvim-treesitter").install({ "lua" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},

			format = {
				enable = true,
			},

			runtime = {
				version = "LuaJIT",
			},

			telemetry = {
				enable = false,
			},

			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

vim.lsp.enable("lua_ls")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

-- stylua defaults to 4c wide tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

local iabbr = utils.iabbr

iabbr("func", [[function()<CR>return<CR>end<Esc>2k_$hi]])
iabbr("fn", [[function () end<Esc>3hi]])
