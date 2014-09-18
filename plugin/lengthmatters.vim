" Prevent from loading multiple times.
if exists('g:loaded_lengthmatters') | finish | endif



" Set some defaults.

" If this is on, the highlighting will be done in every new buffer.
if !exists('g:lengthmatters_on_by_default')
  let g:lengthmatters_on_by_default = 1
endif

" The name of the match (defaults to 'OverLength').
if !exists('g:lengthmatters_match_name')
  let g:lengthmatters_match_name = 'OverLength'
endif

" The colors used to highlight the match.
if !exists('g:lengthmatters_colors')
  let g:lengthmatters_colors = 'ctermbg=lightgray guibg=gray'
endif

" The column at which the highlighting will start.
if !exists('g:lengthmatters_start_at_column')
  let g:lengthmatters_start_at_column = 81
endif



" Force the enabling of the highlighting by setting `w:lengthmatters_active` to
" 1 and by adding the match throught `matchadd`.
function! LengthmattersEnable()
  let w:lengthmatters_active = 1
  let l:regex = '\%' . g:lengthmatters_start_at_column . 'v.\+'
  let w:lengthmatters_match = matchadd(g:lengthmatters_match_name, l:regex)
endfunction

" Force the disabling of the highlighting by setting `w:lengthmatters_active` to
" 0, deleting the previously added match and unletting the
" `w:lengthmatters_match` variable.
function! LengthmattersDisable()
  let w:lengthmatters_active = 0
  call matchdelete(w:lengthmatters_match)
  unlet w:lengthmatters_match
endfunction

" Toggle between active and inactive states.
function! LengthmattersToggle()
  if !exists('w:lengthmatters_active') || !w:lengthmatters_active
    call LengthmattersEnable()
  else
    call LengthmattersDisable()
 endif
endfunction

" This function gets called on every autocmd trigger (defined later in this
" script).
function s:AutocmdTrigger()
  " Force enable if there's no w:lengthmatters_active variable (never
  " enabled/disabled before now) and the default is to activate the
  " highlighting.
  if !exists('w:lengthmatters_active') && g:lengthmatters_on_by_default
    call LengthmattersEnable()
  endif
endfunction



" Highlight the future match once; enabling/disabling is achieved by
" creating/deleting matches and leaving the highlight unmodified. This is useful
" also for when users want to write a custom highlight command, maybe for
" tweaking a colorscheme.
exec 'highlight ' g:lengthmatters_match_name . ' ' . g:lengthmatters_colors



" Execute the matching only if it's enabled by default.
augroup lengthmatters
  autocmd!
  autocmd WinEnter,BufRead * call s:AutocmdTrigger()
augroup END



" Define the `:LengthmattersToggle` command which, guess what, toggles the
" highlighting of long lines.
command! LengthmattersToggle call LengthmattersToggle()



" The plugin has been loaded.
let g:loaded_lengthmatters = 1
