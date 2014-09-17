" Prevent from loading multiple times.
if exists('g:loaded_lengthmatters')
  finish
endif

" Set some defaults.

" The name of the match (defaults to 'OverLength').
if !exists('g:lengthmatters_match_name')
  let g:lengthmatters_match_name = 'OverLength'
endif

" The colors used to highlight the match.
if !exists('g:lengthmatters_colors')
  let g:lengthmatters_colors = 'ctermbg=red guibg=#592929'
endif

" The column at which the highlighting will start.
if !exists('g:lengthmatters_column')
  let g:lengthmatters_column = 81
endif


" Build the highlight and match commands.
" The regex used for matching an overly long line.
let s:regex = '/\%' . g:lengthmatters_column . 'v.*/'
" highlight [name] [colors]
let s:highlight_command =
      \ 'highlight ' . g:lengthmatters_match_name . ' ' . g:lengthmatters_colors
" match [name] [regex]
let s:match_command =
      \ 'match ' . g:lengthmatters_match_name . ' ' . s:regex

" Hook up the matching and highlighting to autocommands.
augroup lengthmatters
  autocmd!
  autocmd BufEnter * exec s:highlight_command
  autocmd BufEnter * exec s:match_command
augroup END


" The plugin has been loaded.
let g:loaded_lengthmatters = 1
