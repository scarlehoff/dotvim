" Do colorscheme first to allow for it to be changed by plugins
set t_Co=256       " Use the terminal wit 256 colors
colorscheme kalisi " Best color scheme out there, desert, but using a different one now, eh

"
" > Global options
"
set nocompatible
let g:pathogen_disabled = []
if v:version < '800' || !has('python')
    call add(g:pathogen_disabled, "completor.vim")
endif
execute pathogen#infect()
" execute pathogen#helptags() " Update helptags
let myfiletypefile = "~/.vim/myfiletypes.vim"
syntax on          " Syntax highlighting on
filetype plugin on " Use filetype plugins
filetype indent on " Use filetype indent
set mouse=a        " Allow use of the mouse
set showcmd        " Show incomplete commands during input
set history=1000   " How many lines of history VIM should remember
set tabpagemax=150 " Not just 10!
set backspace=indent,eol,start " Have 'normal' backspace in insert mode
autocmd FileType tex setlocal isk+=: " very useful for using labels in the form eq:blabla in latex!
let g:tex_flavor = 'latex' " Identify .tex as latex, so vimtex can load them
set hidden

"
" > Style
"
set number         " Precede each line with its line number
set ruler          " Show cursor position at the botton left
set scrolloff=3    " Scroll when cursor get within 3 char of the top/bottom edge
set sidescroll=1   " Left/right
set laststatus=2   " (with 1 we can remove the white line below, config for that line v
set statusline=%F%m%r%h%w\ %{&ff}\ %y\ [L%l,C%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} "Easy peasy
set background=dark

"
" > Performance Settings
"
set lazyredraw " Just in case we are in a slow place (ssh for instance), only actions that change what you see do a redraw
set nowb       " We should not need any backup 
set noswapfile " hopefully, lets see how this goes

"
" > Search Settings
"
set hlsearch   " Highlight search patterns
set incsearch  " Show 'best mach so far' as you type
set ignorecase " Ignore case of letter on searches unless..
set smartcase  " Overrides 'ignorecase' if the search pattern contains upper and lowe case letters

"
" > Wrapping Settings
"
set linebreak " makes sure wrap only happens for characters set in breakat (:./, and the sort, no letters)

"
" > Wildmenu
" 
set wildmenu
set wildmode=longest:full
""" Files to ignore when autocompleting
set wildignore+=.hg,.git,.svn                  " Version control
set wildignore+=*.aux,*.out,*.toc,*.log,*pdf   "LaTeX intermediate files.
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary images
set wildignore+=*.o,*.obj,*.exe,*.dll          " Compiled object files
set wildignore+=*.out,*.mod                    " Fortran binary and mods
set wildignore+=*.pyc                          " Python byte code
set wildignore+=*.spl                          " Compiled spelling word list

"
" > Key Mapping
"
" clipboard control
" ctrl + c == "+y i
vnoremap <C-c> "+y i
noremap ty "+y
noremap tY "+Y
noremap tp "+p
noremap tP "+P
set pastetoggle=<F10>
" disable recording
map q <Nop> 
" disable ex mode
map Q <Nop>
" make j and k behave as the should when navigating through wrapped text
nmap j gj
nmap k gk
" Remap vim 0 to first non-blank
map 0 ^
" Toggle/untoggle spell checking (=z will give you a list of suggestions)
map "ss :setlocal spell!<CR>
" F5 inserts date and my name
nnoremap <F5> "=strftime(" J CM, %d-%b-%Y")<CR>P
inoremap <F5> <C-R>=strftime(" J CM, %d-%b-%Y") J CM<CR>
" pritn -> print
iab pritn print
" Make > and < stay after use
vmap > >gv
vmap < <gv


"
" > Global Folding Settings
" > commented out, trying fastfold
"
set foldmethod=syntax " Fold depending on the lang.
set foldlevelstart=99 "Open file unfolded

"
" > Global Indentation options
" 
set autoindent    " Copy indent from current line when starting a new one
set smartindent   " Try being clever for new-line indenting
set expandtab     " Convert tab to spaces
set smarttab      " When on a <tab>/<bs> will insert/<remove> blanks according to swhiftwidth
set shiftround    " Round indent to multiple of shiftwidth
" Fortran indentation will be different as per fortram.vim
set shiftwidth=4
set tabstop=4     " Number of spaces <tab>s in file counts
set softtabstop=4 " Number of spaces a <tab> counts for when inserting <tab>

"
" > Block commenting, all active for all lang
"
" Python/Bash/Maple
"
vnoremap ~# :s!^!# !<cr>:noh<cr>
vnoremap @# :s!^# !!<cr>:noh<cr>
" Latex
vnoremap ~% :s!^!% !<cr>:noh<cr>
vnoremap @% :s!^% !!<cr>:noh<cr>
" C/C++
vnoremap ~/ :s!^!\/\/!<cr>:noh<cr>
vnoremap @/ :s!^\/\/!!<cr>:noh<cr>
" C/Fortran 77
vnoremap ~c :s!^!c  !<cr>:noh<cr>
vnoremap @c :s!^c  !!<cr>:noh<cr>
" Form
vnoremap ~* :s!^!*  !<cr>:noh<cr>
vnoremap @* :s!^*  !!<cr>:noh<cr>
" Fortran90
vnoremap ~1 :s!^!\!  !<cr>:noh<cr>
vnoremap @1 :s!^\!  !!<cr>:noh<cr>
" Vim
vnoremap ~" :s!^!"  !<cr>:noh<cr>
vnoremap @" :s!^"  !!<cr>:noh<cr>

"
" > If we are using gvim, change a few things
"
if has("gui_running")
    set guioptions-=T " Remove toolbar
    set guioptions+=e " Add tab pages
    set guitablabel=$M\ %t
endif

"
" > Return to last known position when opening files
" 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=% " Remember info about open buffers on close




"
" > Make * and # work do its work in visual selection
" 
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.f')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"
" > Find stuff function
"
nmap gf <c-w>gF
nmap gF :call GoToFunction()<cR>
function! GoToFunction()
    let selWord   = shellescape(expand("<cword>"))
    let pythoncmd = $vimprobe . ' ' .selWord

    let l:list      = system(pythoncmd)
    let l:listFiles = split(l:list, "\n")
    " Hopefully we only found one
    " but we might not be that lucky
    let l:num = len(listFiles)
    let l:i   = 1
    let l:str = ""
    while l:i <= l:num
        let l:str = l:str . l:i . " " . l:listFiles[l:i-1] . "\n"
        let l:i   = l:i + 1
    endwhile
    " Now select file
    if l:num < 1
        echo "No file found for ".selWord
        echo pythoncmd
        return
    elseif l:num != 1
        echo l:str
        let l:input=input("Which?\n")
        if strlen(l:input)==0
            return
        endif
        if strlen(substitute(l:input, "[0-9]", "", "g"))>0
            echo "Not a number"
            return
        endif
        if l:input <1 || l:input>l:num
            echo "Fuck off"
            return
        endif
        let l:line = l:listFiles[l:input-1]
    else
        let l:line = l:list
    endif
    " And now open a new tab!
    execute "tabe ".l:line
endfunction

"
" > Plugin Settings
"
" Syntastic:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list =  1
let g:syntastic_auto_loc_list            =  0
let g:syntastic_check_on_open            =  1
let g:syntastic_check_on_wq              =  0
let g:syntastic_mode_map                 =  { 'mode': 'passive', 'active_filetypes': ["tex"],'passive_filetypes': [] }
nmap <F8> :SyntasticToggleMode <CR>

" Tabular:
vnoremap <F3> :Tab /=<CR> 

" NERDTree
" Surely there must be an easier way...
" This function makes NERDTree highlight on whatever file you happened to be
" when it opens and, if it is already opened, every time you change buffer
" and, contrary to other internet solutions, it let you close nerdtree...
let g:nerdTreeOpen=0
nmap <F7> :call CustomNERDTreeToggle() <CR>
function! CustomNERDTreeToggle() 
    let g:nerdTreeOpen=0
    let s:isNerdTreeActive=exists("t:NERDTreeBufName")
    if (s:isNerdTreeActive)
        let s:isNerdTreeShown=bufwinnr(t:NERDTreeBufName)
        if (s:isNerdTreeShown != -1) 
            NERDTreeClose
        else
            NERDTreeFind
            wincmd p
            let g:nerdTreeOpen=1
        endif
    else
        NERDTreeFind
        wincmd p
        let g:nerdTreeOpen=1
    endif
endfunction
autocmd BufEnter * if (&modifiable && g:nerdTreeOpen) | NERDTreeFind | wincmd p | endif

" Open nerdtree when openning a new directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close vim when only nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" RainbowParentheses:
nmap <F9> :RainbowParenthesesToggle <CR>

" " 
" Defaults: (already set like this by vim)
" > Apparience
" set laststatus=1   " 2 gives more info but uses an extra line...
" set statusline=%F%m%r%h%w\ %{&ff}\ %y\ [L%l,C%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} "Easy peasy
" > Performance
" set ttyfast    " Improves performance in tmux
" > Wrapping
" set wrap      " wrap does the wrapping visually instead of changing the buffer
" set nolist    " When text is wrapped don't create a new line
" set encoding=utf-8 " Yes, that
" set nobackup       " Don't keep backups
" set foldlevel=0       " Fold it all!
" set foldlevelstart=99 "Open file unfolded
" "

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" Fix the annoying behaviour of Kalisi with matching
hi MatchParen ctermbg=0 ctermfg=200 

" Completor
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_auto_trigger = 0 " Don't activate completor by default! 
function! CompletorToggle()
    if (g:completor_auto_trigger == 0)
        let g:completor_auto_trigger = 1
    else
        let g:completor_auto_trigger = 0
    endif
endfunction
noremap <C-@> :call CompletorToggle() <CR>
inoremap <C-@> <c-o>:call CompletorToggle()<CR>

