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
"
if executable('zathura')
    let g:vimtex_view_method = 'zathura'
endif

"  if executable('mupdf')
"      let g:vimtex_view_method = 'mupdf'
"      let g:vimtex_view_automatic = 0
"  endif

if !executable('latexmk')
    let g:vimtex_compiler_enabled = 0
endif


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

let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \ 'hyperref',
      \]

" Don't open a window on warnings!
let g:vimtex_quickfix_open_on_warning = 0
