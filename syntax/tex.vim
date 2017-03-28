nnoremap <leader>cc :call ConcealToggle()<CR>
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

