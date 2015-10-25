" autoload plugin stuff {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" }}}

" color {{{
syntax enable " enable syntax processing
" }}}

" spaces and tabs {{{
set shiftwidth=4 " indenting is 4 spaces
set tabstop=4 " number of visual spaces per TAB
set expandtab " tabs are spaces
syntax on
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\
            \ [%l/%L]\ (%p%%)
"tab
" for command mode
nnoremap <S-Tab> <<
nnoremap <Tab> >>
" for insert mode
inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>
" for visual mode
vnoremap <S-Tab> <
vnoremap <Tab> >
" }}}

" UI config {{{
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype plugin indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need
set showmatch " highlight matching {[()]}
" }}}

" searching {{{
set incsearch " search as characters are entered
set hlsearch " highlight matches
" turn off search highlight
noremap <leader>/ :nohlsearch<CR>
" }}}

" folding {{{
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
" space open/closes folds
" noremap <space> za
set foldmethod=indent " fold based on indent level
"}}} 

" movement {{{
" move vertically by visual line
noremap j gj
noremap k gk
" move to beginning/end of line
noremap B ^
noremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV '[v']
" }}}

" <leader> bindings {{{
" explicit mapping of <leader>= \  and <localleader>= ,
let mapleader="\\" 
let localmapleader="," ",
"vimrc editing
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"edit vimrc and load vimrc bindings
map <leader>ev :vsp $MYVIMRC <CR>
map <F9> :vsplit ~/.vim/vimrc <CR>
map <leader>wv :source $MYVIMRC <CR> :echo "NEW VIMRC LOADED!" <CR>
map <F6> :so ~/.vimrc<CR> :echo "NEW VIMRC LOADED!" <CR>
" save session
nnoremap <leader>s :mksession <CR>
" }}}

" auto commands {{{
augroup vimrc_autocmd
" ensures commands are loaded only once
    autocmd!
    " au[tocmd] [group] {event} {patern} [nested] {cmd}
    " group = [aug[roup], ...] " examples: aug_new
    " event = [VimEnter, BufWritePre, FileType, BufEnter, ...]
    " FileTypePattern = [python, cpp, rst, ...]
    "
    " Commenting blocks of code.
    autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
    autocmd FileType sh,ruby,python   let b:comment_leader = '# '
    autocmd FileType conf,fstab       let b:comment_leader = '# '
    autocmd FileType tex              let b:comment_leader = '% '
    autocmd FileType mail             let b:comment_leader = '> '
    autocmd FileType vim              let b:comment_leader = '" '
    noremap <silent> <localmapleader>c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localmapleader>u :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
    "python
    autocmd FileType python set autoindent
    autocmd FileType python set smartindent
    autocmd FileType python set textwidth=79 " PEP-8 Friendlynting
    autocmd FileType python map <leader>/n O# Note:<cr>
    autocmd FileType python map <leader>/t O# TODO:<cr>
    "C
    autocmd FileType cpp set cindent      " - stricter rules for C programs
    autocmd FileType cpp map <leader>//n O//Note:
    autocmd FileType cpp map <leader>//a O//ATTENTION
    autocmd FileType cpp map <leader>//f O//FINISHED

    autocmd FileType rst map <leader>1 2O<ESC>i##<ESC>jo##<ESC>k
    autocmd FileType rst map <leader>2 O<ESC>i**<ESC>jo**<ESC>k
    autocmd FileType rst map <leader>3 o==<ESC>k
    autocmd FileType rst map <leader>4 o--<ESC>k
    autocmd FileType rst map <leader>5 o^^<ESC>k
    autocmd FileType rst map <leader>6 o""<ESC>k

    autocmd FocusLost * :set number
    autocmd FocusGained * :set relativenumber

    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
augroup END
" }}} 

" miscellaneous stuff i'm too lazy to group right now {{{
set clipboard=unnamed " copy into system clipboard
set backspace=indent,eol,start
set gfn=Monospace\ 12 " font
set colorcolumn=80 " column at 80

set splitbelow
set splitright
nnoremap Y y$



""""formatting""""
map <leader><space> =ip
map <leader><space>g gg=G :echo "Indenting whole file." <cr>


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
set number
set timeoutlen=5000
set nocompatible 

"search
set incsearch
set smartcase
set hlsearch



"copy paragraphs
noremap yp yap<S-}>p

"move between panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

set nocompatible
" }}}

" tell vim to to structure this file differently
set modelines=1
" vim:foldmethod=marker:foldlevel=0
