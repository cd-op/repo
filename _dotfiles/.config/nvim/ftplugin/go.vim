set noexpandtab

" go install golang.org/x/tools/gopls@latest
" go install golang.org/x/tools/cmd/goimports@latest
" go install mvdan.cc/gofumpt@latest
" go install honnef.co/go/tools/cmd/staticcheck@latest
let b:ale_linters = ['gopls', 'govet', 'staticcheck']
let b:ale_fixers = ['gopls', 'goimports', 'gofumpt']
let b:ale_go_staticcheck_options = '-checks all'

inoreabbrev stru type struct{<CR>i int<CR>}<Esc>2k_4li
inoreabbrev iface type interface{<CR>A() *A<CR>}<Esc>2k_4li
inoreabbrev func func() {<CR>return<CR>}<Esc>2k_4li
inoreabbrev fn func(){}<Esc>hi

inoreabbrev gomain package main<CR><CR>import (<CR>"fmt"<CR>)<CR><CR>func main() {<CR>fmt.Println("Hello!")<CR>}<Esc>O
