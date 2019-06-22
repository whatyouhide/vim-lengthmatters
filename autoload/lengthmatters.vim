" Force the highlighting of the matched group to be linked with another `group`.
"   call lengthmatters#highlight_link_to('Comment')
function! lengthmatters#highlight_link_to(group)
  " Remove the 'other' variable (from lengthmatters#highlight).
  if exists('g:lengthmatters_highlight_colors')
    unlet g:lengthmatters_highlight_colors
  endif

  let g:lengthmatters_linked_to = a:group
  if get(w:, 'lengthmatters_active', 0) | exec 'LengthmattersReload' | endif
endfunction


" Force the highlighting of the matched group to be with `colors`, which is a
" string of colors like the ones the :hi command accepts:
"   call lengthmatters#highlight('ctermbg=10 ctermfg=2')
function! lengthmatters#highlight(colors)
  " Remove the 'other' variable (from lengthmatters#highlight_link_to).
  if exists('g:lengthmatters_linked_to')
    unlet g:lengthmatters_linked_to
  endif

  let g:lengthmatters_highlight_colors = a:colors
  if get(w:, 'lengthmatters_active', 0) | exec 'LengthmattersReload' | endif
endfunction
