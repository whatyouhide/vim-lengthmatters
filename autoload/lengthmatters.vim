" Force the highlighting of the matched group to be linked with another `group`.
"   call lengthmatters#highlight_link_to('Comment')
function! lengthmatters#highlight_link_to(group)
  let g:lengthmatters_highlight_command =
        \ 'highlight link ' .
        \ g:lengthmatters_match_name . ' ' .
        \ a:group
  LengthmattersReload
endfunction


" Force the highlighting of the matched group to be with `colors`, which is a
" string of colors like the ones the :hi command accepts:
"   call lengthmatters#highlight('ctermbg=10 ctermfg=2')
function! lengthmatters#highlight(colors)
  let g:lengthmatters_highlight_command =
        \ 'highlight ' . g:lengthmatters_match_name . ' ' . a:colors
  LengthmattersReload
endfunction
