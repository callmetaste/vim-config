"execute pathogen#infect()
"syntax on
"filetype plugin indent on

set clipboard=unnamed
set backspace=indent,eol,start
set gfn=Monospace\ 12
set colorcolumn=80

"always copy/paste into system clipboard
"causing freezing
"map y "+y
"map p "+gP

"indent
syntax on
filetype plugin indent on
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\
  \ [%l/%L]\ (%p%%)
set tabstop=4    " - tabs are at proper location
set shiftwidth=4 " - indenting space
set expandtab    " - don't use actual tab character (ctrl-v)
set foldmethod=indent
" for command mode
nnoremap <S-Tab> <<
nnoremap <Tab> >>
" for insert mode
inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>
" for visual mode
vnoremap <S-Tab> <
vnoremap <Tab> >

"python
au FileType py map <F5> :w !python - 
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendlynting

"C
au FileType cpp set cindent      " - stricter rules for C programs

"rst
au FileType rst map <leader>1 2O<ESC>i==<ESC>jo==<ESC>k
au FileType rst map <leader>2 o~~<ESC>k


""""formatting""""
map <leader><space> =ip
map <leader><space>G gg=G 
map <leader><leader>= O<ESC>10a=<ESC>10a=<ESC>9hi
map <leader><leader>" O<ESC>4a"<ESC>4a"<ESC>3hi

"commenting/uncommenting
map <leader>// :s/^/\/\//<cr>
map <leader>/<space> :s/^\/\///<cr>
map <leader>//n O//Note:
map <leader>//a O//ATTENTION
map <leader>//f O//FINISHED

"commenting/uncommenting
map <leader>"" :s/^/\"<cr>
map <leader>"<space> :s/^\"<cr>
map <leader>"n O//Note:
map <leader>"a O//ATTENTION
map <leader>"f O//FINISHED

"moving line up/down
map <M-j> ddp 
map <M-k> ddkP 
map <M><down> ddp
map <M><up> ddkP

"duplicate line
map <leader>y Yp
map <leader>p o<esc>p
map <leader>P O<esc>p

"stop sucking
set ruler
set laststatus=2
set showcmd
set showmode
set number
set timeoutlen=5000
set nocompatible 

"search
set incsearch
set ignorecase
set smartcase
set hlsearch

"vimrc editing
map <leader>evim :vsp $MYVIMRC <CR>
map <leader>wvim :source $MYVIMRC <CR> :echo "NEW VIMRC LOADED!" <CR>
map <F9> :vsplit ~/.vimrc<CR>
map <F6> :so ~/.vimrc<CR> :echo "NEW VIMRC LOADED!" <CR>


"copy paragraphs
noremap cp yap<S-}>p

"move between panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

set nocompatible

function! NumberToggle()
    if(&relativenumber ==1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

au FocusLost * :set number
au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
auto InsertLeave * :set relativenumber


