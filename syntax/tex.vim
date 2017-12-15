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
