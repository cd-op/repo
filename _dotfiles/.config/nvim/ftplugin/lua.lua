local cmd, b, o = vim.cmd, vim.b, vim.o

-- stylua defaults to 4c wide tabs
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = false

b.ale_linters = { "luacheck", "lua-language-server" }
b.ale_fixers = { "stylua" }

for _, x in ipairs({
	{ "func", [[function()<CR>return<CR>end<Esc>2k_$hi]] },
	{ "fn", [[function () end<Esc>3hi]] },
}) do
	cmd.inoreabbrev({ args = x })
end
