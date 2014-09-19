" Prevent from loading multiple times.
if exists('g:loaded_lengthmatters') | finish | endif



" Set some defaults.

" If this is on, the highlighting will be done in every new buffer/window.
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

" The filetypes where we don't want any highlighting.
if (!exists('g:lengthmatters_excluded'))
  let g:lengthmatters_excluded = [
        \ 'unite', 'tagbar', 'startify',
        \ 'gundo', 'vimshell', 'w3m',
        \ 'nerdtree']
endif



" Force the enabling of the highlighting by setting `w:lengthmatters_active` to
" 1 and by adding the match throught `matchadd`.
function! LengthmattersEnable()
  " Do nothing if this is an excluded filetype.
  if s:InExcludedFiletypes() | return | endif

  let w:lengthmatters_active = 1
  call s:Highlight()

  " Create a new match if it doesn't exist already (in order to avoid creating
  " multiple matches for the same window).
  if !exists('w:lengthmatters_match')
    let l:regex = '\%' . g:lengthmatters_start_at_column . 'v.\+'
    let w:lengthmatters_match = matchadd(g:lengthmatters_match_name, l:regex)
  endif
endfunction


" Force the disabling of the highlighting by setting `w:lengthmatters_active` to
" 0, deleting the previously added match and unletting the
" `w:lengthmatters_match` variable.
function! LengthmattersDisable()
  let w:lengthmatters_active = 0

  if exists('w:lengthmatters_match')
    call matchdelete(w:lengthmatters_match)
    unlet w:lengthmatters_match
  endif
endfunction


" Toggle between active and inactive states.
function! LengthmattersToggle()
  if !exists('w:lengthmatters_active') || !w:lengthmatters_active
    call LengthmattersEnable()
  else
    call LengthmattersDisable()
 endif
endfunction


" Check if we're in an excluded filetype buffer.
function! s:InExcludedFiletypes()
  return index(g:lengthmatters_excluded, &ft) >= 0
endfunction


" Execute the highlight command.
function! s:Highlight()
  exec 'highlight ' g:lengthmatters_match_name . ' ' . g:lengthmatters_colors
endfunction


" This function gets called on every autocmd trigger (defined later in this
" script). It disables the highlighting on the excluded filetypes and enables it
" if it wasn't enabled/disabled before.
function! s:AutocmdTrigger()
  if s:InExcludedFiletypes()
    call LengthmattersDisable()
  elseif !exists('w:lengthmatters_active') && g:lengthmatters_on_by_default
    call LengthmattersEnable()
  endif
endfunction



augroup lengthmatters
  autocmd!

  " Enable (if it's the case) on a bunch of events (the filetype event is there
  " so that we can avoid highlighting excluded filetypes.
  autocmd WinEnter,BufEnter,BufRead,FileType * call s:AutocmdTrigger()

  " Re-highlight the match on every colorscheme change (includes bg changes).
  autocmd ColorScheme * call s:Highlight()
augroup END



" Define the `:LengthmattersToggle` command which, guess what, toggles the
" highlighting of long lines.
command! LengthmattersToggle call LengthmattersToggle()



" The plugin has been loaded.
let g:loaded_lengthmatters = 1
