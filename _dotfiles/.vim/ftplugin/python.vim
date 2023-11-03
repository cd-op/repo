let b:ale_linters = ['flake8', 'mypy', 'jedils']
let b:ale_fixers = ['autopep8']

inoreabbrev def def():<CR>pass<Esc>k_3li

inoreabbrev pymain import sys<CR><CR><CR>def main() -> int:<CR>return 0<CR><Esc>0i<CR><CR>if __name__ == '__main__':<CR>sys.exit(main())<Esc>5ko
