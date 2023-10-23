"let b:ale_linters   " same as for c,
"let b:ale_fixers    " c.vim file also loaded
let b:ale_cpp_cc_options = '-std=c++17 -Wall -Wextra -Wconversion -Wsign-conversion'

inoreabbrev fn [](){}<Esc>2hi
inoreabbrev class class ClassName: public BaseClass<CR>{<CR>public:<CR>ClassName(): BaseClass() {}<CR>};<Esc>4k02wi

inoreabbrev cppmain #include <iostream><CR><CR>int main(int argc, char ** argv)<CR>{<CR>std::cout << "Hello!" << std::endl;<CR>return 0;<CR>}<Esc>2kA
