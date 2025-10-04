local vim = vim -- luacheck: ignore

local b = vim.b
local o = vim.o

local api = vim.api
local cmd = vim.cmd
local keymap = vim.keymap
local lsp = vim.lsp

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
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local encoding = "utf-8"

		local params = lsp.util.make_range_params(0, encoding)
		params.context = {
			only = { "source.organizeImports" },
		}

		local result = lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)

		for cid, res in pairs(result or {}) do
			local e = (lsp.get_client_by_id(cid) or {}).offset_encoding

			for _, r in pairs(res.result or {}) do
				if r.edit then
					lsp.util.apply_workspace_edit(r.edit, e or encoding)
				end
			end
		end

		lsp.buf.format({ async = false })
	end,
})

-- the lsp setup for gopls breaks ALEGoToDefinition
-- use same functionality from the lsp instead
keymap.set("n", "gd", lsp.buf.definition, { noremap = true })
keymap.set("n", "<C-LeftMouse>", lsp.buf.definition, { noremap = true })
keymap.set("i", "<C-LeftMouse>", lsp.buf.definition, { noremap = true })

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
