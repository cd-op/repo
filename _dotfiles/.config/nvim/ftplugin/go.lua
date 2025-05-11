local cmd, b, o = vim.cmd, vim.b, vim.o

o.expandtab = false

--[[
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
--]]
b.ale_linters = { "gopls", "govet", "staticcheck" }
b.ale_fixers = {} -- disable all fixers, use autocmd instead
b.ale_go_staticcheck_options = "-checks all"

-- use gopls+gofumpt to fix imports and format on save
-- gofumpt is selected as formatter at lsp setup
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end

		vim.lsp.buf.format({ async = false })
	end,
})

-- the lsp setup for gopls breaks ALEGoToDefinition
-- use same functionality from the lsp instead
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("i", "<C-LeftMouse>", vim.lsp.buf.definition, { noremap = true })

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
	cmd.inoreabbrev({ args = x })
end
