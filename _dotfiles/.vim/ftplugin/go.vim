set noexpandtab

let g:go_fmt_command = "goimports"

inoreabbrev stru type struct{<CR>i int<CR>}<Esc>2k_4li
inoreabbrev iface type interface{<CR>A() *A<CR>}<Esc>2k_4li
inoreabbrev func func() {<CR>return<CR>}<Esc>2k_4li
inoreabbrev fn func(){}<Esc>hi

inoreabbrev gomain package main<CR><CR>import (<CR>"fmt"<CR>)<CR><CR>func main() {<CR>fmt.Println("Hello!")<CR>}<Esc>O
