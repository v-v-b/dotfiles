" botstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" general
syntax on
filetype plugin indent on

set noswapfile
set nobackup
set nowrap
set autoread

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set incsearch

set list
set listchars=eol:¬,tab:■■,trail:█

set relativenumber
set signcolumn=yes
set colorcolumn=80

set mouse=a
let mapleader=','
let maplocalleader=','

set splitbelow
set splitright

" ale beforeload
" :CocConfig and add "diagnostic.displayByAle": true
"let g:ale_disable_lsp=1

" plugins
call plug#begin(stdpath('data') . '/plugged')
" help for vim-plug itself
Plug 'junegunn/vim-plug'

" color
Plug 'gruvbox-community/gruvbox'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" filetree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" statusline
Plug 'vim-airline/vim-airline'

" linter
Plug 'dense-analysis/ale'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" clojure
Plug 'Olical/conjure', {'tag': 'v4.9.0'}

" racket
Plug 'wlangstroth/vim-racket'

"Plug 'tomtom/tcomment_vim'

"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-surround'

"Plug 'luochen1990/rainbow'

"Plug 'bhurlow/vim-parinfer'

"Plug 'jgdavey/tslime.vim'

"Plug 'janko/vim-test'
"Plug 'guns/vim-sexp',    {'for': 'clojure'}
"Plug 'venantius/vim-cljfmt'
"Plug 'leafgarland/typescript-vim'

"Plug 'takac/vim-hardtime'
call plug#end()

" colorscheme
set termguicolors
let g:gruvbox_contrast_dark='hard'
color gruvbox
hi SignColumn guibg=' '

" airline
let g:airline#extensions#ale#enabled=1
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_alt_sep='|'

"vim-gitgutter
set updatetime=100

"nerdtree
map <C-n> :NERDTreeToggle<CR>

"nerdtree-git-plugin
let g:NERDTreeShowIgnoredStatus=1

" fzf
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-P> :Files<Cr>

" ale
function! JokerFix(buffer) abort
    return {
    \   'command': 'joker --format -',
    \}
endfunction

execute ale#fix#registry#Add('joker', 'JokerFix', ['clojure'], 'joker format for clojure')

let g:ale_linters_explicit=1
let g:ale_linters = {
      \ 'clojure': ['clj-kondo', 'joker'],
      \ }
let g:ale_fixers = {
      \ 'clojure': ['joker']
      \ }
let g:ale_fix_on_save=1
let g:ale_echo_msg_format = '[%linter%][%severity%] %s '
nmap <silent> [ag <Plug>(ale_previous_wrap)
nmap <silent> ]ag <Plug>(ale_next_wrap)

" coc
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-conjure',
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-eslint',
      \]
" code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" <TAB> to trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" <CR> to auto-select the first completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" K to show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" highlight the symbol and its references
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f :Prettier<CR>
nmap <leader>F :Prettier<CR>:w<CR>

" racket
if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=racket
  au filetype racket set lisp
  au filetype racket set autoindent
endif

