" autoload plugin stuff {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
let g:pymode_rope_autoimport=0
" }}}

" color {{{
syntax enable " enable syntax processing
colorscheme badwolf
" }}}

" spaces and tabs {{{
syntax on " allows vim to highlight language syntax based on filetype
set shiftwidth=4 " indenting is 4 spaces
set tabstop=4 " number of visual spaces per TAB
set expandtab " tabs are spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " highlights whitespace
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\
            \ [%l/%L]\ (%p%%) " detailed command bar
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
filetype plugin indent on " load filetype-specific indent files
set showcmd " show command in bottom bar
set history=200 " a longer command history
set wildmenu " visual autocomplete for command menu
" cursor
set virtualedit=onemore " allows cursor beyond last char
set scrolljump=7
set scrolloff=5
" readability
set formatoptions=1 lbr " linewrapping
set number " show line numbers
set cursorline " highlight current line
" set lazyredraw " redraw only when we need
set ttyfast
set wrap
set colorcolumn=80 " column at 80
" searching
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
set foldlevelstart=0 " open most folds by default
set foldmethod=indent " fold based on indent level
nmap <leader>f0 :set foldlevel=0<CR>>
nmap <leader>f1 :set foldlevel=1<CR>>
nmap <leader>f2 :set foldlevel=2<CR>>
nmap <leader>f3 :set foldlevel=3<CR>>
nmap <leader>f4 :set foldlevel=4<CR>>
nmap <leader>f5 :set foldlevel=5<CR>>
nmap <leader>f6 :set foldlevel=6<CR>>
nmap <leader>f7 :set foldlevel=7<CR>>
nmap <leader>f8 :set foldlevel=8<CR>>
nmap <leader>f9 :set foldlevel=9<CR>>



"}}} 

" movement {{{
" move vertically by visual line
noremap j gj
noremap k gk
" move by line when given a movement
onoremap j j
onoremap k k
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
let maplocalleader=","
"vimrc editing
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"edit vimrc and load vimrc bindings
map <leader>ev :vsp $MYVIMRC <CR>
map <F9> :vsplit ~/.vim/vimrc <CR>
map <leader>wv :source $MYVIMRC <CR> :echom "NEW VIMRC LOADED!" <CR>
map <F6> :so ~/.vimrc<CR> :echom "NEW VIMRC LOADED!" <CR>
" turn spelling on/off
function! SpellToggle()
    if(&spell==1) " currently enabled, set to disabled
        echom "SPELL CHECK OFF"
        set nospell
    else " currently disabled, set to enable
        echom "SPELL CHECK ON" 
        setlocal spell spelllang=en_us
    endif
endfunc
nnoremap <leader>= :call SpellToggle()<cr>

" save session
nnoremap <leader>s :mksession <CR>
" }}}

" auto commands {{{
augroup vimrc_autocmd
" ensures commands are loaded only once
    autocmd!
    " Implementation comments
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
    noremap <silent> <localleader>c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localleader>u :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
    " Aligns comments
    " "<C-R>" pastes the register while "=escape()" assigns the register a
    " value
    noremap <silent> <localleader><Tab> :Tab /<C-R>=escape(b:comment_leader,'\/')<CR><CR>
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
    autocmd FocusGained * :redraw!
augroup END
" }}} 

" miscellaneous stuff i'm too lazy to group right now {{{
set clipboard=unnamed " copy into system clipboard
set backspace=indent,eol,start
set gfn=Monospace\ 12 " font

set splitbelow
set splitright



""""formatting""""
map <leader><space> =ip
map <leader><space>g gg=G :echom "Indenting whole file." <cr>


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
