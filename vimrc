" notes {{{

" function ToggleFlag(option,flag)
"   exec ('let lopt = &' . a:option)
"   if lopt =~ (".*" . a:flag . ".*")
"     exec ('set ' . a:option . '-=' . a:flag)
"   else
"     exec ('set ' . a:option . '+=' . a:flag)
"   endif
" endfunction
" map <silent> <F7> :call ToggleFlag("guioptions","m")<CR>
" map <silent> <F8> :call ToggleFlag("guioptions","T")<CR>


" }}}

" autoload plugin stuff {{{
" resets several options to their defaults
set nocompatible 
runtime bundle/vim-pathogen/autoload/pathogen.vim
runtime /home/mate/.vim/bundle/color-pack/plugin/ScrollColor.vim
execute pathogen#infect()
call pathogen#infect()
call pathogen#helptags()
let g:pymode = 1
let g:rainbow_active = 1
let g:tex_conceal = ''
let g:ycm_allow_changing_updatetime = 0

" ensure that autocommands are only loaded once
autocmd!
" }}}

" {{{ unmappings
autocmd VimEnter * call Unmappings()
function! Unmappings()
    " unmaps current color
    " select register to paste
    nmap <leader>p :reg <cr>
            \:call GetRegister()<cr>
    " unmaps current color status
    " replace the current word with yank
    nmap <leader>c viwc<C-R>0<esc>
endfunction
" }}}

" instantrst {{{
" let g:instant_rst_static = 'mars.css'
" }}}

" pymode {{{
nmap <f7> :PymodeLint<cr>
nmap <s-f7> :PymodeLintAuto<cr>
nmap <f8> :vert lopen<cr>
let g:pymode_python = 'python'
" ignore error code for unnecessary parenthesis
" ignore import errors
" let g:pymode_lint_ignore = "C0325, F0401"
" use these error checkers
" let g:pymode_lint_checkers = ['mccabe', 'pep8', 'pyflakes', 'pylint']
let g:pymode_lint_on_write = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_sort = ['E']

let g:pymode_rope_completion = 0
let g:pymode_rope_autoimport=0

" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 0
" let g:pymode_syntax_print_as_function = 0
" let g:pymode_syntax_highlight_equal_operator = 0
" let g:pymode_syntax_highlight_stars_operator = 0
" let g:pymode_syntax_highlight_self = 1
" let g:pymode_syntax_indent_errors = 0
" let g:pymode_syntax_space_errors = 0
" let g:pymode_syntax_string_formatting = 0
" let g:pymode_syntax_string_format = 0
" let g:pymode_syntax_string_templates = 0
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_types = 0
" let g:pymode_syntax_highlight_exceptions = 0
" let g:pymode_syntax_doctests = 1
" let g:pymode_syntax_docstrings = 1

" }}}

" syntastic {{{
autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd FileType python set errorformat=%f:%l:\ %m

" nmap <s-f7> :SyntasticCheck<cr>
" nmap <f7> :vert lopen<cr>
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_shell = "/bin/bash"

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_always_populate_loc_list = 1
" Automatically open/close location-list
let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_stl_format =
            \'[%E{|Err| = %e: %fe}%B{, }%W{|Warn| = %w: %fw}]'
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"


let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["python"] }

" }}}

" surround {{{
" makes adding parenthesis easy
nmap <leader>) csw)
vmap <leader>) <S-S>)
" }}}

" UI config {{{
nmap <silent><f4> :SCROLLCOLOR<cr>
filetype plugin indent on "load filetype-specific indent files
set gfn=Monospace\ 12     "font
set showcmd               "show command in bottom bar
" rename screen title
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")             
set title
" detailed command bar
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L]\ (%p%%)\ 
            \\ %{SyntasticStatuslineFlag()}
set updatetime=5000
set history=200 "a longer command history
set wildmenu    "visual autocomplete for command menu
set lines=30 columns=85
set autochdir
nmap <s-f12> :w<cr>
nmap <f5> :tabn<cr>
nmap <s-f5> :tabp<cr>
" shift+mouse selects blocks
noremap <c-LeftMouse> <4-LeftMouse>
inoremap <c-LeftMouse> <4-LeftMouse>
onoremap <c-LeftMouse> <C-C><4-LeftMouse>
noremap <c-LeftDrag> <LeftDrag>
inoremap <c-LeftDrag> <LeftDrag>
onoremap <c-LeftDrag> <C-C><LeftDrag>
set hidden "allows switching between files without needing to save
set splitright
set splitbelow
" copy into system clipboard = +
nmap <leader>y "+y
set clipboard=unnamedplus
set backspace=indent,eol,start
" Map Ctrl-BS and Ctrl-Del to delete the previous word in insert mode.
imap <C-BS> <C-W>
imap <C-del> <esc>lvedi
" cursor
set virtualedit=onemore "allows cursor beyond last char
set scrolljump=7        "automatically scroll n when the cursor hits the edge
set scrolloff=5         "keep the cursor n lines from the edge
" set cursorline          "highlight current line
" readability
set formatoptions=1 lbr "linewrapping
set number              "show line numbers
set ttyfast
set wrap
set textwidth=0 wrapmargin=0
set colorcolumn=80 " column at 80 "
" highlight character at 72
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%<73v.\%>72v/
" searching
set showmatch     "highlight matching {[()]}
set ruler
set laststatus=2
set ttimeoutlen=100
set timeoutlen=5000
nmap == :set textwidth=72<CR>gqj:set textwidth=79<CR>
" }}}

" color {{{
syntax enable " enable syntax processing
if has("gui_running")
    colorscheme badwolf
else
"     colorscheme neon
    colorscheme badwolf
endif
" }}}

" spaces and tabs {{{
syntax on                                   "allows vim to highlight language
                                            "syntax based on filetype
syntax sync minlines=256                    "speed up syntax. The trade off is
                                            "there might be some inaccuracies with highlighting
set synmaxcol=250 "fixes slow downs with really long lines


set shiftwidth=4                         "indenting is 4 spaces
set tabstop=4                            "number of visual spaces per TAB
set expandtab                            "tabs are spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ "highlights whitespace

" openning a line in insert mode
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

" searching {{{
set incsearch "search as characters are entered
set hlsearch  "highlight matches
set ignorecase
set smartcase
set regexpengine=1 "use earlier regex implementation. faster results
" turn off search highlight
noremap <leader>/ :nohlsearch<CR>
" }}}

" folding {{{
set foldenable        "enable folding
set foldlevelstart=0  "open most folds by default
set foldmethod=indent "fold based on indent level
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
" set mouse
set mouse=a
" move vertically by visual line
noremap j gj
noremap k gk
" move by line when given a movement
onoremap j j
onoremap k k
" move to beginning/end of line
" together with virtualedit=onemore, moves the cursor one more
noremap B ^
noremap E $
vnoremap E $h
noremap W $l
" $/^ doesn't do anything
" nnoremap $ <nop>
" nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV '[v']
"moving line up/down
map <M-j> ddp 
map <M-k> ddkP 
map <M><down> ddp
map <M><up> ddkP
"move between panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
" }}}

" <leader> bindings {{{
" explicit mapping of <leader> \  and <localleader> ,
let mapleader="\\"
let maplocalleader=","
" temp 
nmap <localleader><localleader> whxvExi()<esc>hp
"vimrc editing
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"edit vimrc and load vimrc bindings
map <leader>ev :vsp $MYVIMRC <CR>
map <F9> :tabedit ~/.vim/vimrc<CR>
map <leader>wv :source $MYVIMRC <CR> :echom "NEW VIMRC LOADED!" <CR>
map <s-F9> :so ~/.vimrc<CR> :echom "NEW VIMRC LOADED!" <CR>

let $rst='/home/mate/.vim/bundle/personal/plugin/rst.vim'
" turn spelling on/off
function! SpellToggle()
    if(&spell==1) " currently enabled, set to disabled
        echom "SPELL CHECK OFF. "
        set nospell
    else " currently disabled, set to enable
        echom "SPELL CHECK ON. Suggestions:z= next:]s" 
        setlocal spell spelllang=en_us
    endif
endfunc
nnoremap <leader>= :call SpellToggle()<cr>

function! GetRegister()
    call inputsave()
    let b:register_value = input("enter the register to paste \n")
    call inputrestore()
    echo ''
    if(b:register_value)
        let cmd = "normal! \""
        let cmd .= b:register_value
        let cmd .= "p"
"         echom cmd
        silent exe cmd
    endif
endfunction

" save session
nnoremap <leader>s :mksession <CR>
" }}}

" auto commands {{{
augroup vimrc_autocmd
    " Implementation comments
    " au[tocmd] [group] {event} {patern} [nested] {cmd}
    " group = [aug[roup], ...] 
    "   examples: aug_new
    " event = [VimEnter, BufWritePre, FileType, BufEnter, ...]
    " FileTypePattern = [python, cpp, rst, ...]
    "
    " Commenting blocks of code.

    autocmd FileType c,cpp,java,scala,cs let b:comment_leader = '// '
    autocmd FileType conf,fstab,apache   let b:comment_leader = '# '
    autocmd FileType tex                 let b:comment_leader = '% '
    autocmd FileType mail                let b:comment_leader = '> '
    autocmd FileType vim                 let b:comment_leader = '" '
    autocmd FileType sh,ruby             let b:comment_leader = '# '
    autocmd FileType python              let b:comment_leader = '# '


    noremap <silent> <localleader>c
                \ :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')
                \ <CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localleader>u
                \ :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')
                \ <CR>//e<CR>:nohlsearch<CR>

    " Aligns comments
    " "<C-R>" pastes the register while "=escape()" assigns the register a
    " value
    noremap <silent> <localleader><Tab> 
                \ :Tab /<C-R>=escape(b:comment_leader,'\/')<CR><CR>
    "python
"     autocmd FileType python set autoindent
    autocmd FileType python set smartindent

    noremap <silent> <localleader>>
                \ :<C-B>silent <C-E>s/^/<C-R>=escape('    >>> ', '\/')
                \ <CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localleader><
                \ :<C-B>silent <C-E>s/^\V<C-R>=escape('    >>> ', ' \/')
                \ <CR>//e<CR>:nohlsearch<CR>

"     autocmd FileType python set textwidth=79 " PEP-8 Friendlynting
    autocmd FileType python map <localleader>n O# Note:<cr>"""<cr>"""<esc>O
    autocmd FileType python map <localleader>t O# TODO:<cr>"""<cr>"""<esc>O
    "C
    autocmd FileType cpp set cindent      " - stricter rules for C programs
    autocmd FileType cpp map <localleader>n O//Note:
    autocmd FileType cpp map <localleader>a O//ATTENTION
    autocmd FileType cpp map <localleader>f O//FINISHED

"     autocmd FocusLost * :set norelativenumber
"     autocmd FocusGained * :set relativenumber
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"     autocmd InsertEnter * :set norelativenumber
"     autocmd InsertLeave * :set relativenumber
    autocmd CursorMoved * if LongEnough( "b:myTimer", 5, 5 ) | set nocursorline norelativenumber| endif
    autocmd CursorHold * :set cursorline relativenumber   "updatetime=2000


    autocmd FocusGained * :redraw!

"     autocmd InsertEnter * :set relativenumber
"     autocmd InsertLeave * :set norelativenumber
"     nnoremap <silent> v v:<C-u>set rnu<CR>gv
"     nnoremap <silent> V V:<C-u>set rnu<CR>gv
"     nnoremap <silent> <C-v> <C-v>:<C-u>set rnu<CR>gv
"     vnoremap <Esc> <Esc>:set nornu<CR>


" Returns true if at least delay seconds have elapsed since the last time this function was called, based on the time
" contained in the variable "timer". The first time it is called, the variable is defined and the function returns
" true.
"
" True means not zero.
"
" For example, to execute something no more than once every two seconds using a variable named "b:myTimer", do this:
"
" if LongEnough( "b:myTimer", 2 )
"   <do the thing>
" endif
"
" The optional 3rd parameter is the number of times to suppress the operation within the specified time and then let it
" happen even though the required delay hasn't happened. For example:
"
" if LongEnough( "b:myTimer", 2, 5 )
"   <do the thing>
" endif
"
" Means to execute either every 2 seconds or every 5 calls, whichever happens first.
function! LongEnough( timer, delay, ... )
  let result = 0
  let suppressionCount = 0
  if ( exists( 'a:1' ) )
    let suppressionCount = a:1
  endif
  " This is the first time we're being called.
  if ( !exists( a:timer ) )
    let result = 1
  else
    let timeElapsed = localtime() - {a:timer}
    " If it's been a while...
    if ( timeElapsed >= a:delay )
      let result = 1
    elseif ( suppressionCount > 0 )
      let {a:timer}_callCount += 1
      " It hasn't been a while, but the number of times we have been called has hit the suppression limit, so we activate
      " anyway.
      if ( {a:timer}_callCount >= suppressionCount )
        let result = 1
      endif
    endif
  endif
  " Reset both the timer and the number of times we've been called since the last update.
  if ( result )
    let {a:timer} = localtime()
    let {a:timer}_callCount = 0
  endif
  return result
endfunction
augroup END
" }}} 
" auto group md {{{
augroup filetypedetect_md
    au!
    
    " Headings
    au FileType md nnoremap <leader>h1 ^yypv$r=o<cr><esc>
    au FileType md inoremap <leader>h1 <esc>^yypv$r=o<cr>

    au FileType md nnoremap <leader>h2 ^yypv$r-o 
                \  <cr><cr><cr><cr><cr><cr><esc> kkkk
    au FileType md inoremap <leader>h2 <esc>^yypv$r-o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki 
    au FileType md nnoremap <leader>h3 ^yypv$r+o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h3 <esc>^yypv$r+o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki

    au FileType md nnoremap <leader>h4 ^yypv$r~o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h4 <esc>^yypv$r~o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki

    au FileType md nnoremap <leader>h5 ^yypv$r*o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h5 <esc>^yypv$r*o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki



    """Make Link (ml)
    " Highlight a word or phrase and it creates a link and opens a split so
    " you can edit the url separately. Once you are done editing the link,
    " simply close that split.
    au FileType md vnoremap <leader>ml yi`<esc>gvvlli`_<esc>:vsplit
                \<cr><C-W>l:$<cr>o<cr>.. _<esc>pA: http://TODO<esc>vb
    """Make footnote (ml)
    au FileType md iabbrev mfn [#]_<esc>:vsplit<cr><C-W>l:$<cr>o<cr>.. [#] TODO
    au FileType md set spell
    "Create image
    au FileType md iabbrev iii .. image:: TODO.png
                \<cr>    :scale: 100<cr>:align: center<cr><esc>kkkeel
    "Create figure
    au FileType md iabbrev iif .. figure:: TODO.png
                \<cr>    :scale: 100<cr>:align: center
                \<cr>:alt: TODO<cr><cr><cr>Some brief description<esc>kkkeel

    "Create note
    au FileType md iabbrev nnn .. note:: 
    "Start or end bold text inline
    au FileType md inoremap <leader>bb **
    "Start or end italicized text inline
    au FileType md inoremap <leader>ii *
    "Start or end preformatted text inline
    au FileType md inoremap <leader>pf ``

    " Fold settings
    "au FileType md set foldmethod=marker
    
    " Admonitions
    au FileType md iabbrev adw .. warning::
    au FileType md iabbrev adn .. note::
augroup END
" }}} 








" }}}

" tell vim to to structure this file differently
set modelines=1
" vim:foldmethod=marker:foldlevel=0
