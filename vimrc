"
" > Colorscheme and visual options first to allow for plugins to change it
"
colorscheme kalisi
set t_Co=256       " Use the terminal with 256 colors

"
" > Global options (vim only as nvim should have these by default, and some 
" vim as well)
"
filetype plugin on " Use filetype plugins
syntax on          " Syntax highlighting on
set backspace=indent,eol,start " Allow backspace to also remove lines
set background=dark
set encoding=utf-8
set laststatus=2   " (with 1 we can remove the white line below, config for that line v
set history=1000   " How many lines of history VIM should remember
set mouse=a        " Allow use of the mouse
set noswapfile     " hopefully, lets see how this goes
set showcmd        " Show incomplete commands during input
set ruler          " Show cursor position at the botton rightA
set wildmenu
set wildmode=longest:full

source ~/.vim/vimrc_shared

"
" > Search Settings
"
set hlsearch   " Highlight search patterns
set incsearch  " Show 'best mach so far' as you type
" Sometimes it is useful to do "search under the cursor" but without moving the cursor : nnoremap * *N

" This one doesn't work with nvim
if has(!'nvim')
    set ttymouse=sgr   " Fix a problem with the mouse past a certain column
endif

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

" ######################################
" > Plugins 
" ######################################
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" > vim-plug
" note for the future: look into using conditions in the pluging loading for
" different extensions on mac
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
" nerdtree:
nmap <F7> :call CustomNERDTreeToggle() <CR>
" coc.nvim (opens in a vertical split, coc.preferences.jumpCommand": "vsp")
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual


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
