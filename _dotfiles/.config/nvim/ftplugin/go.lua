local utils = require("utils")

if utils.missing_progs("gopls", "staticcheck") then
	return
end

require("nvim-treesitter").install({ "go" })

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			gofumpt = true,
			staticcheck = true,
		},
	},
})

vim.lsp.enable("gopls")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local encoding = "utf-8"

		local params = vim.lsp.util.make_range_params(0, encoding)
		params.context = {
			only = { "source.organizeImports" },
		}

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)

		for cid, res in pairs(result or {}) do
			local e = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding

			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, e or encoding)
				end
			end
		end

		vim.lsp.buf.format({ async = true })
	end,
})

local nmap = utils.nmap

nmap("gd", vim.lsp.buf.definition)
nmap("gD", vim.lsp.buf.declaration)
nmap("gr", vim.lsp.buf.references)
nmap("gi", vim.lsp.buf.implementation)

for _, x in ipairs({
	{ "stru", [[<Esc>bitype <Esc>Astruct{<CR>}<Esc>O]] },
	{ "iface", [[<Esc>bitype <Esc>Ainterface{<CR>}<Esc>O]] },
	{ "func", [[<Esc>bifunc <Esc>A( xw )  {<CR>}<Esc>k$Txciw]] },
	{ "tfunc", [[<Esc>bifunc Test<Esc>A(t* testing.T)  {<CR>}<Esc>O]] },
	{ "fn", [[func(){ xw }<Esc>Txciw]] },
	{ "enil", [[if err != nil {<CR>}<Esc>O]] },
	{
		"gomain",
		[[package main<CR><CR>import (<CR>"fmt"<CR>)<CR><CR>func main() {<CR>fmt.Println("Hello!")<CR>}<Esc>O]],
	},
}) do
	vim.cmd.inoreabbrev({ args = x })
end
