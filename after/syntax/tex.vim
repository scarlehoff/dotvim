" Make sure align is understood as a math environment
" in theory this should now be fixed in vimtex
"if !exists("g:tex_no_math")
"    call TexNewMathZone("E", "align", 1)
"endif
set textwidth=120 " Force lines to be of 120 characters
