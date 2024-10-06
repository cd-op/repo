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

for _, x in ipairs({
	-- { "stru", [[type struct{<CR>i int<CR>}<Esc>2k_4li]] },
	-- { "iface", [[type interface{<CR>A() *A<CR>}<Esc>2k_4li]] },
	{ "stru", [[<Esc>bitype <Esc>Astruct{<CR>}<Esc>O]] },
	{ "iface", [[<Esc>bitype <Esc>Ainterface{<CR>}<Esc>O]] },
	-- { "func", [[func() {<CR>return<CR>}<Esc>2k_4li]] },
	{ "func", [[<Esc>bifunc <Esc>A( xw )  {<CR>}<Esc>k$Txciw]] },
	{ "fn", [[func(){ xw }<Esc>Txciw]] },
	{ "enil", [[if err != nil {<CR>}<Esc>O]] },
	{
		"gomain",
		[[package main<CR><CR>import (<CR>"fmt"<CR>)<CR><CR>func main() {<CR>fmt.Println("Hello!")<CR>}<Esc>O]],
	},
}) do
	cmd.inoreabbrev({ args = x })
end
