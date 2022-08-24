" Do colorscheme first to allow for it to be changed by plugins
set t_Co=256       " Use the terminal wit 256 colors
colorscheme kalisi
if has("gui_running")
    " remove menubar
    set guioptions -=m
else
    " transparent bg
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
endif

"
" > Global options
"
set nocompatible
set encoding=utf-8
let myfiletypefile = "~/.vim/myfiletypes.vim"
filetype plugin on " Use filetype plugins
syntax on          " Syntax highlighting on
filetype indent on " Use filetype indent
set mouse=a        " Allow use of the mouse
if !has("nvim")
    set ttymouse=sgr   " Fix the problem with the mouse past column 220
endif
set mmp=5000      " Fix the problem I have sometimes in markdown since I have memory to spare
set re=1
set showcmd        " Show incomplete commands during input
set history=1000   " How many lines of history VIM should remember
set tabpagemax=150 " Not just 10!
set backspace=indent,eol,start " Have 'normal' backspace in insert mode
autocmd FileType tex setlocal isk+=: " very useful for using labels in the form eq:blabla in latex!
autocmd FileType bib setlocal isk+=: " very useful for using labels in the form eq:blabla in latex!
let g:tex_flavor = 'latex' " Identify .tex as latex, so vimtex can load them
let g:vimtex_view_method = 'zathura' " Now needs to be set here instead of in tex.vim? why?
let g:vimtex_compiler_latexmk = {
            \ 'options' : [
                \   '-shell-escape',
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}
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
" F5 inserts date
nnoremap <F5> "=strftime("%d-%b-%Y")<CR>P
inoremap <F5> <C-R>=strftime("%d-%b-%Y")<CR>
" pritn -> print
iab pritn print
" Make > and < stay after use
vmap > >gv
vmap < <gv
" Make <F8> highlight the current word
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


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
" > If we forgot to use sudo to open a file
" 
cmap w!! w !sudo tee > /dev/null %

"
" > Return to last known position when opening files
" 
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
set viminfo^=% " Remember info about open buffers on close

" Open in new tab when doing gf
nnoremap gf <C-W>gf
vnoremap gf <C-W>gf


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

autocmd BufRead,BufNewFile *.run set filetype=nnlojet


highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
" Fix the annoying behaviour of Kalisi with matching
hi MatchParen ctermbg=0 ctermfg=200 

"
" > vim-plug
" note for the future: look into using conditions in the pluging loading for
" different extensions on mac
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeFind'} |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'lervag/vimtex', {'for': ['latex', 'tex', 'bib']}
    Plug 'digitaltoad/vim-pug', { 'for': ['pug'] }
    Plug 'freeo/vim-kalisi' "colorscheme
    Plug 'godlygeek/tabular', {'on': 'Tab'}
    Plug 'dkarter/bullets.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"
" > Plugin Settings
"
"
" >> Tabular:
vnoremap <F3> :Tab /=<CR> 

" >> fzf.vim
noremap <F4> :Rg<CR>
let g:fzf_action = {
    \ 'enter': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit'
    \}

" >> Coc.nvim:
" >>> Extensions:
" esbonio is for rst/sphinx and rome for js, ts, json, html, md and css
" clangd might need :CocCommand clangd.install from a C-file
let g:coc_global_extensions = [
  \ 'coc-esbonio',
  \ 'coc-pyright',
  \ 'coc-vimtex',
  \ 'coc-yaml',
  \ 'coc-tsserver',
  \ 'coc-highlight',
  \ 'coc-git',
  \ 'coc-rust-analyzer',
  \ 'coc-clangd',
  \ ]

hi CocFloating ctermbg=darkgray ctermfg=white
hi CocMenuSel ctermbg=82 ctermfg=black
set pumheight=5 " Avoid having 3 thousand items in the completion list

" You will have bad experience for diagnostic messages when it uses the default 4000.
set updatetime=500
" always show signcolumns
set signcolumn=yes
" Use <CR> to accept selected completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <tab> to navigate completion
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"  inoremap <silent><expr> <TAB>
"              \ pumvisible() ? "\<C-n>" :
"              \ <SID>check_back_space() ? "\<TAB>" :
"              \ coc#refresh()
"  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"  
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" >> NERDtree:
" Opens Nerdtree when pressing F7 and highlights the file you are on, press it again to close
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

autocmd FileType python let b:coc_root_patterns = ['.pyrightconfig.json']
