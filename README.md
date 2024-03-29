# lengthmatters.vim

Highlight the part of a line that doesn't fit into `textwidth` (or really,
whatever width you like).

I've had this functionality in my `.vimrc` for a long time, and finally decided
to extract it into a plugin. The idea is extremely simple, a gazillion examples
of how to to this can be found online, but still... I like making plugins.

## Maintenance

I had stopped maintaining this project but the superkind Francisco (@oblitum) stepped
up and offered to take over maintenance, so he's the maintainer now. Thanks Francisco! :heart_decoration:

## Installation

I personally moved from [Vundle][vundle] to [vim-plug][vim-plug] a while ago and
never looked back. Anyways, whatever floats your boat:
``` viml
" vim-plug
Plug 'whatyouhide/vim-lengthmatters'
" NeoBundle
NeoBundle 'whatyouhide/vim-lengthmatters'
" Vundle
Plugin 'whatyouhide/vim-lengthmatters'
```

You pathogen dinosaurs can just clone the repo:
```
git clone https://github.com/whatyouhide/vim-lengthmatters.git ~/.vim/bundle
```


## What's in it

The highlighting functionality operates always on a **per-window** basis,
meaning you can keep it enabled on a window and disabled on another one at the
same time.

By default, it's based on the value of the `textwidth` option (it *feels*
right), but this can be changed in the options. See `:h 'textwidth'` for more
infos.

The plugin provides a bunch of commands:

- `:LengthmattersToggle`: toggle the highlighting for the current window
- `:LengthmattersEnable`: enable the highlighting for the current window
- `:LengthmattersDisable`: disable the highlighting for the current window
- `:LengthmattersReload`: force reloading (useful if something goes wrong, or
    `textwidth` changes, or god knows what)
- `:LengthmattersEnableAll`: enable the highlighting for all open windows
- `:LengthmattersDisableAll`: disable the highlighting for all open windows


## Configuration

To set a variable in vim (for example `g:foo` to the string `foo`), just do:

``` viml
let g:foo = 'foo'
```

Most of the configuration for this plugin can be done through a handful of
variables. The only thing you have to use functions for is highlighting. Read
the [relative section](#hl) for how to do it.

#### `g:lengthmatters_on_by_default`

(defaults to `!&diff`)  
If this variable is set to `0`, no highlighting will be done
when opening a new window. Highlighting can still be activated with one of the
previously mentioned commands.

#### `g:lengthmatters_start_at_column`

(defaults to `81`)  
The value of this variable is the *first character* to be highlighted; the
highlighting will continue until the end of the line. This means that if it's
okay for lines to be `40` characters long (because you're from 1920 or 
something) you set this variable to `41`.

#### `g:lengthmatters_use_textwidth`

(defaults to `1`)  
Whether to highlight based on the value of `textwidth`. If `textwidth` is not
set, it will fall back to `g:lengthmatters_start_at_column`.

#### `g:lengthmatters_excluded`

(defaults to
`['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m',
'nerdtree', 'help', 'qf', 'dirvish']`)  

A list of **filetypes** for which the highlighting isn't (and can't be) enabled.
They're regular expressions, so, for example, to disable highlighting in any
helper debug window of [vim-go](https://github.com/fatih/vim-go), one can add
`'godebug.*'` to the list.

#### `g:lengthmatters_exclude_readonly`

(defaults to `1`)  
If this variable is set to `1`, no highlighting will be done when opening a
read-only file.

#### `g:lengthmatters_match_name`

(defaults to `'OverLength'`)  
The name of the syntax element that will be used to highlight and match the
overly long lines.

#### `g:lengthmatters_highlight_one_column`

(defaults to `0`)  
Only highlight one column instead of all columns up to EOL.

### <a name=hl></a> Highlighting

The plugin provides a default highlighting which is based on the current
colorscheme. The foreground color is taken from the background color of the
`Normal` highlight group, while the background color is taken from the
foreground color of the `Comment` group. This *should* look decent on pretty
much every colorscheme.

If you want to change that, you have two options.

##### `lengthmatters#highlight`

To change the actual colors, use the `lengthmatters#highlight` function:
``` viml
call lengthmatters#highlight('ctermbg=3 ctermfg=10')
```

##### `lengthmatters#highlight_link_to`

To link the group to another highlight group, use the
`lengthmatters#highlight_link_to` function:
``` viml
call lengthmatters#highlight_link_to('ColorColumn')
```

**Note** that you have to use one of these two functions in order to manipulate
the highlighting, since the plugin performs some dark magic behind the scenes in
order to keep the highlighting (and you) happy.

The highlighting is reloaded when you call one of the functions, just as if you
called `:LengthmattersReload`.

### <a name=hl></a> Adapt line length for different file types

Different line length in different file types can be achieved with the
`textwidth` variable. For example, if the default line is 80 characters
and we want to have a line length of 120 characters only in Java files,
we can do it like this:

```viml
autocmd bufreadpre *.java setlocal textwidth=120
```

## Testing

If you want to test this plugin, be sure you have [vader.vim][vader] installed,
then open `tests/lengthmatters.vader` and run `:Vader`.


## License

&copy; Andrea Leopardi

[![][wtfpl-logo]][wtfpl]

[vundle]: https://github.com/gmarik/Vundle.vim
[vim-plug]: https://github.com/junegunn/vim-plug
[wtfpl]: http://www.wtfpl.net/
[wtfpl-logo]: http://www.wtfpl.net/wp-content/uploads/2012/12/logo-220x1601.png
[vader]: https://github.com/junegunn/vader.vim
