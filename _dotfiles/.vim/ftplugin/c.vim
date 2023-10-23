let b:ale_linters = ['cc', 'ccls']
let b:ale_fixers = ['astyle']
let b:ale_c_cc_options = '-std=c11 -Wall -Wextra -Wconversion -Wsign-conversion'

inoreabbrev func void (int arg) {<CR>return<CR>}<Esc>2k_4li

inoreabbrev cmain #include <stdio.h><CR><CR>int main(int argc, char** argv)<CR>{<CR>printf("Hello!");<CR>return 0;<CR>}<Esc>2kA
