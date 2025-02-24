"
" > Colorscheme and visual options first to allow for plugins to change it
"
set t_Co=256       " Use the terminal wit 256 colors
colorscheme kalisi

"
" > Global options
"
set encoding=utf-8
let myfiletypefile = "~/.vim/myfiletypes.vim"
filetype plugin on " Use filetype plugins
syntax on          " Syntax highlighting on
filetype indent on " Use filetype indent
set mouse=a        " Allow use of the mouse
set showcmd        " Show incomplete commands during input
if !has("nvim") | set ttymouse=sgr | endif   " Fix the problem with the mouse past column 220
set mmp=10000      " Allow more memory (x10) for pattern matching (useful in markdown)
set history=1000   " How many lines of history VIM should remember
set tabpagemax=150 " Not just 10!
set backspace=indent,eol,start " Allow backspace to also remove lines

"
" > Global Folding Settings (zc, zo, za)
"
set foldmethod=syntax " Fold depending on the lang.
set foldlevelstart=99 " Open file unfolded

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
" > Latex options
"
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

" set hidden <--- since I rarely use buffers I should not need this, but maybe
" some plugin requires it?

"
" > Style
"
set number         " Precede each line with its line number
set ruler          " Show cursor position at the botton left
set scrolloff=3    " Scroll when cursor get within 3 char of the top/bottom edge
set sidescroll=1   " Left/right
set laststatus=2   " (with 1 we can remove the white line below, config for that line v
set background=dark

" Only-gvim options
if has("gui_running")
    set guioptions -=m " remove menubar
    set guioptions-=T " Remove toolbar
    set guioptions+=e " Add tab pages
    set guitablabel=$M\ %t
elseif has("mac")
    " transparent bg
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
endif

" vimdiff options
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
" Fix the annoying behaviour of Kalisi with matching
hi MatchParen ctermbg=0 ctermfg=200 

"
" > Statusline definition
"
" Start with the full filepath
set statusline+=%F
" Decorate with flags: [modified?] [read only?] [is help?] [is preview?]
set statusline+=%m%r%h%w
" Add fileformat and type
set statusline+=\ %{&ff}\ %y
" Location within the file
set statusline+=\ [L%l/%L,C%v][%p%%]

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
" Sometimes it is useful to do "search under the cursor" but without moving the cursor : nnoremap * *N

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

" F5 inserts date
nnoremap <F5> "=strftime("%d-%b-%Y")<CR>P
inoremap <F5> <C-R>=strftime("%d-%b-%Y")<CR>
" F8 highlights the current word amd occurrences without moving
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" F10, enters paste mode
set pastetoggle=<F10>
" disable ex mode
map Q <Nop> 
" Remap vim 0 to first non-blank
map 0 ^
" make j and k navegate through wrapper text as seen in the screen
nmap j gj
nmap k gk
" Toggle/untoggle spell checking (=z will give you a list of suggestions)
map "ss :setlocal spell!<CR>
" Make > and < stay after use
vmap > >gv
vmap < <gv
" pritn -> print
iab pritn print
 
"
" > Clipboard control
"
" Use t as a shorthand for using the system clipbard
noremap ty "+y
noremap tY "+Y
noremap tp "+p
noremap tP "+P

"
" > If we forgot to use sudo to open a file
" 
cmap w!! w !sudo tee > /dev/null %

" I want to use @ for uncommenting stuff, so map the playback of the recording to \q
noremap <leader>q @

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

" ######################################
" > Plugins 
" ######################################

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
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'ojroques/vim-oscyank', {'branch': 'main'}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"
" > Triggers
"
" tabular:
vnoremap <F3> :Tab /=<CR>
" fzf:
noremap <F4> :Rg<CR>
" nerdtree:
nmap <F7> :call CustomNERDTreeToggle() <CR>
" coc.nvim (opens in a verticual split, coc.preferences.jumpCommand": "vsp")
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual


"
" > Plugin Settings

" > fzf.vim
let g:fzf_action = {
    \ 'enter': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
" This might be needed for MacOs
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    set rtp+=/opt/homebrew/opt/fzf
endif

" > coc.nvim:
" >> Extensions:
" esbonio is for rst/sphinx and rome for js, ts, json, html, md and css
" clangd might need :CocCommand clangd.install from a C-file to work
let g:coc_global_extensions = [
  \ 'coc-esbonio',
  \ 'coc-pyright',
  \ 'coc-vimtex',
  \ 'coc-tsserver',
  \ 'coc-highlight',
  \ 'coc-git',
  \ 'coc-rust-analyzer',
  \ 'coc-clangd',
  \ 'coc-snippets',
  \ ]

" change the colors for the floating menus, (maybe ctermbg could be darkgray)
hi CocFloating ctermbg=gray ctermfg=white
hi CocMenuSel ctermbg=82 ctermfg=black
hi CocWarningFloat ctermfg=193 ctermbg=240 guifg=#ff922b
set pumheight=5 " Avoid having 3 thousand items in the completion list

" You will have bad experience for diagnostic messages when it uses the default 4000.
set updatetime=500
" always show signcolumns
set signcolumn=yes
" Use <CR> to accept selected completion
"  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" In order to make <CR> work with bullets and coc.nvim at the same time, we
" need to modify <CR> with <Plug>(bullets-newline) like below: https://github.com/bullets-vim/bullets.vim/issues/85
" Basically, we don't allow bullet to add the keymapping and just add the call
" to <Plug>(bullet-newline) together with the coc-nvim <CR>
let g:bullets_set_mappings = 0
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() 
                            \: "\<C-g>u\<Plug>(bullets-newline)\<c-r>=coc#on_enter()\<CR>"

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

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd FileType python let b:coc_root_patterns = ['.pyrightconfig.json']

" > NERDtree:
" Press t to open files in a new tab
let g:nerdTreeOpen=0
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


