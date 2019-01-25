



"""""""""""""
" vim-jedi:
"      Completion <C-Space>
"      Goto assignments <leader>g (typical goto function)
"      Goto definitions <leader>d (follow identifier as far as possible, includes imports and statements)
"      Show Documentation/Pydoc K (shows a popup with assignments)
"      Renaming <leader>r
"      Usages <leader>n (shows all the usages of a name)
"      Open module, e.g. :Pyimport os (opens the os module)

" vim-jedi settings
" disable jedi by default:
"  let g:jedi#auto_initialization = 0

" Complete only when pressing ctrl+space
" note this overrides ctrl+space for completortoggle
"  let g:jedi#popup_on_dot = 0
"  
"  " Use a top split (just like with the docstring) when going to a definition
"  "  let g:jedi#use_splits_not_buffers = "top"
"  let g:jedi#use_tab_not_buffers = 1
"  
"  " Goto definition
"  let g:jedi#goto_assignments_command = ""
"  
