" Vim syntax file for NNLOJET runcards
 
" add to your .vimrc the following:
" autocmd BufRead,BufNewFile *.run set filetype=nnlojet

if exists("b:current_syntax")
    finish
endif

" Comments: reg expr, comment everything .* until the end of the line $
syn match f90Comment "!.*$"
syn keyword f90Comment NNLOJET_RUNCARD PHYSICAL_PARAMETERS
hi link f90Comment Comment


""""" Fortran-type syntax (partly from fortran.vim)
"" Integers
syn match fortranNumber	display "\<\d\+\(_\a\w*\)\=\>"
" floating point number, without a decimal point
syn match fortranFloat	display	"\<\d\+[deq][-+]\=\d\+\(_\a\w*\)\=\>"
" floating point number, starting with a decimal point
syn match fortranFloat	display	"\.\d\+\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, no digits after decimal
syn match fortranFloat	display	"\<\d\+\.\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, D or Q exponents
syn match fortranFloat	display	"\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number
syn match fortranFloat	display	"\<\d\+\.\d\+\(e[-+]\=\d\+\)\=\(_\a\w*\)\=\>"

syn match fortranBoolean "\.\s*\(true\|false\)\s*\."

hi link fortranBoolean Boolean
hi link fortranNumber Number
hi link fortranFloat Float


""""" NNLOJET syntax
syn keyword nnFunctions select accept reject

syn keyword nnKeys min max nbins output_type
syn keyword nnKeys muf mur
syn keyword nnKeys fac Rcone
syn keyword nnKeys delta n etmax etratio ethreshold frix etsum epsilon
syn keyword nnKeys nocuts fixS
syn keyword nnKeys PDF tcut scale_coefficients multi_channel scale_coefficients phase_space warmup iseed
syn keyword nnKeys collider sqrts jet decay_type
syn keyword nnKeys MASS WIDTH SCHEME GF

syn region nnOR matchgroup=nnRegions start="OR" end="END_OR" fold transparent contains=ALL
syn region nnSELECTOR matchgroup=nnRegions start="\(SELECTORS\|HISTOGRAM_SELECTORS\)" end="\(END_SELECTORS\|END_HISTOGRAM_SELECTORS\)" fold transparent contains=ALL
syn region nnPROCESS matchgroup=nnRegions start="PROCESS" end="END_PROCESS" fold transparent contains=ALLBUT, fortranNumber
syn region nnRUN matchgroup=nnRegions start="RUN" end="END_RUN" fold transparent contains=ALLBUT, fortranNumber
syn region nnPARAMETERS matchgroup=nnRegions start="PARAMETERS" end="END_PARAMETERS" fold transparent contains=ALLBUT, fortranNumber
syn region nnCHANNELS matchgroup=nnRegions start="CHANNELS" end="END_CHANNELS" fold transparent contains=ALLBUT, fortranNumber
syn region nnHISTOGRAMS matchgroup=nnRegions start="HISTOGRAMS" end="END_HISTOGRAMS" fold transparent contains=ALL
syn region nnSCALES matchgroup=nnRegions start="SCALES" end="END_SCALES" fold transparent contains=ALL
syn region nnMULTI matchgroup=nnRegions start="MULTI_RUN" end="END_MULTI_RUN" fold transparent contains=ALL

syn keyword nnSpecials UNIT_PHASE MINLO PDF_INTERPOLATION PHOTON_ISOLATION REWEIGHT

" Define the highlighting
hi link nnKeys Operator
hi link nnFunctions Function
hi link nnRegions Conditional
hi link nnSpecials Conditional

let b:current_syntax = 'nnlojet_runcards'
