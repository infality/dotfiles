call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/vim-clang-format'
    Plug 'vim-airline/vim-airline'
   "Plug 'vim-airline/vim-airline-themes'
   "Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'arcticicestudio/nord-vim'
    Plug 'tell-k/vim-autopep8'
    Plug 'preservim/nerdcommenter'
call plug#end()

let g:nord_cursor_line_number_background = 1
colorscheme nord

se cul
hi clear CursorLine
hi cursorlinenr guifg=bold
augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight Comment ctermfg=7
  autocmd ColorScheme nord highlight Visual ctermbg=8
augroup END


let g:cpp_experimental_template_highlight = 1

let g:clang_format#style_options = {
            \ "ColumnLimit" : "170"}

syntax enable
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab
set number
filetype indent on
set autoindent
set wrap
set linebreak
set mouse=a

nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
nnoremap J }zz
nnoremap K {zz
nnoremap <esc> :noh<return><esc>
nnoremap # *Nzz

nnoremap <C-i> J
vnoremap <C-i> J

vnoremap J }zz
vnoremap K {zz

vnoremap <C-y> "+y
nnoremap <C-p> "+p

nnoremap <Space>h ^
nnoremap <Space>H 0
nnoremap <Space>l g_
nnoremap <Space>L $

nmap <silent> gk <Plug>(coc-diagnostic-prev)
nmap <silent> gj <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

let g:autopep8_disable_show_diff=1
let g:airline_powerline_fonts = 1
"let g:airline_theme='bubblegum'

"hi Pmenu ctermbg=238 ctermfg=250
"hi PmenuSel ctermbg=red ctermfg=black
"hi PmenuSbar ctermbg=238
"hi PmenuThumb ctermbg=250
"hi SignColumn ctermbg=NONE ctermfg=NONE

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

noremap <C-Space> :call CocActionAsync('showSignatureHelp')<CR>

autocmd BufNewFile,BufRead *.tex noremap <C-S> :w<CR>:!latexmk '%' -pdf -output-directory=%:h<CR>:!latexmk -c<CR>
autocmd BufNewFile,BufRead *.cpp noremap <C-S> :w<CR>:!./run.sh<CR>
autocmd BufNewFile,BufRead *.pde noremap <C-S> :w<CR>:!processing-java --sketch=%:t:r --run<CR>
autocmd BufNewFile,BufRead *.cpp,*.c,*.cu,*.h,*.hpp nnoremap > :ClangFormat<CR>
autocmd BufNewFile,BufRead *.py nnoremap > :Autopep8<CR>
autocmd BufNewFile,BufRead *.rs nnoremap > :%! rustfmt<CR>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

