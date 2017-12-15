nnoremap <leader>cc :call ConcealToggle()<CR> 
" leader = \, \ll to autocompile latex
colorscheme kalisi
" Fix the annoying behaviour of Kalisi with matching
hi MatchParen ctermbg=0 ctermfg=200 
function! ConcealToggle()
    if &conceallevel == 0
        set conceallevel=2
    else
        set conceallevel=0
    endif
endfunction
set concealcursor=nvc
let g:tex_conceal="adgms"

" Looks for the line I'm in with \lv from vim to zathura and with ctrl+left
" click from zathura to vim
let g:vimtex_view_method = 'zathura' 

" Don't open a window on warnings!
let g:vimtex_quickfix_open_on_warning = 0

" Vimtex keybinds
nnoremap <leader>cw :VimtexCountWords <CR> 

" Vimtex keybinds
" <leader>lT :VimtexTocToggle (small t for open)
" <leader>lY :VimtexLabelsToggle (small y for open)
" <leader>li :VimtexInfo
" <leader>lo :VimtexCompileOutput
" <leader>le :VimtexErrors
" <leader>lc or <leader>lC :VimtexClean (cleans *.aux, *.out, with ! also the pdf) 
" :VimtexCountLetters
" For the rest look at https://github.com/lervag/vimtex/wiki/usage#default-mappings


" Silence parts of syntastic
let g:syntastic_quiet_messages = { 
    \"type": "style" ,
    \"regex": [
        \ '\mpossible unwanted space at "{"'
        \]
\}
