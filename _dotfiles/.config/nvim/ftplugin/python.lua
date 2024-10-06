local cmd, b = vim.cmd, vim.b

b.ale_linters = { "flake8", "mypy", "jedils" }
b.ale_fixers = { "autopep8" }

for _, x in ipairs({
	{ "def", [[def():<CR>pass<Esc>k_3li]] },
	{
		"pymain",
		[[import sys<CR><CR><CR>def main() -> int:<CR>return 0<CR><Esc>0i<CR><CR>if __name__ == '__main__':<CR>sys.exit(main())<Esc>5ko]],
	},
}) do
	cmd.inoreabbrev({ args = x })
end
