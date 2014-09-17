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
if !exists('g:lengthmatters_column')
  let g:lengthmatters_column = 81
endif


" Enable the highlighting by creating a new match (through `matchadd`) or by
" using the match which already exists for this buffer.
function! LengthmattersEnable()
  if exists('b:lengthmatters_match') | return | endif

  " Create a new match.
  let l:regex = '\%' . g:lengthmatters_column . 'v.\+'
  let b:lengthmatters_match = matchadd(g:lengthmatters_match_name, l:regex)
endfunction

" Disable the highlighting by deleting the match associated with this buffer.
function! LengthmattersDisable()
  if !exists('b:lengthmatters_match') | return | endif
  call matchdelete(b:lengthmatters_match)
  unlet b:lengthmatters_match
endfunction

" Toggle between active and inactive states.
function! LengthmattersToggle()
  if exists('b:lengthmatters_match')
    call LengthmattersDisable()
  else
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
  autocmd BufEnter,BufReadPost,BufNewFile *
        \ if g:lengthmatters_on_by_default |
        \   call LengthmattersEnable() |
        \ endif
augroup END


" Define the `:LengthmattersToggle` command which, guess what, toggles the
" highlighting of long lines.
command! LengthmattersToggle call LengthmattersToggle()


" The plugin has been loaded.
let g:loaded_lengthmatters = 1
