local cmd, b = vim.cmd, vim.b

b.ale_linters = { "cc", "ccls" }
b.ale_fixers = { "astyle" }
b.ale_c_cc_options = "-std=c11 -Wall -Wextra -Wconversion -Wsign-conversion"

for _, x in ipairs({
	{ "func", [[void (int arg) {<CR>return<CR>}<Esc>2k_4li]] },
	{
		"cmain",
		[[#include <stdio.h><CR><CR>int main(int argc, char** argv)<CR>{<CR>printf("Hello!");<CR>return 0;<CR>}<Esc>2kA]],
	},
}) do
	cmd.inoreabbrev({ args = x })
end
