local cmd, b = vim.cmd, vim.b

-- b.ale_linters -> same as for c,
-- b.ale_fixers  -> c.vim file also loaded
b.ale_cpp_cc_options = "-std=c++17 -Wall -Wextra -Wconversion -Wsign-conversion"

for _, x in ipairs({
	{ "fn", "[](){}<Esc>2hi" },
	{ "class", [[class ClassName: public BaseClass<CR>{<CR>public:<CR>ClassName(): BaseClass() {}<CR>};<Esc>4k02wi]] },
	{
		"cppmain",
		[[#include <iostream><CR><CR>int main(int argc, char ** argv)<CR>{<CR>std::cout << "Hello!" << std::endl;<CR>return 0;<CR>}<Esc>2kA]],
	},
}) do
	cmd.inoreabbrev({ args = x })
end
