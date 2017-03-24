nnoremap <leader>cc :call ConcealToggle()<CR>
colorscheme kalisi
function! ConcealToggle()
    if &conceallevel == 0
        set conceallevel=2
    else
        set conceallevel=0
    endif
endfunction
set concealcursor=nvc
let g:tex_conceal="adgms"

