# lengthmatters.vim

![travis-ci](https://travis-ci.org/whatyouhide/vim-lengthmatters.svg?branch=master)

Highlight the part of a line that doesn't fit into `textwidth` (or really,
whatever width you like).

![screenshot][screenshot]

I've had this functionality in my `.vimrc` for a long time, and finally decided
to extract it into a plugin. The idea is extremely simple, a gazillion example
of how to to this can be found online, but still... I like making plugins.

## Installation

I personally moved from [Vundle][vundle] to [vim-plug][vim-plug] a while ago and
never looked back. Anyways, whatever floats your boat:
``` viml
" vim-plug
Plug 'whatyouhide/lengthmatters'
" NeoBundle
NeoBundle 'whatyouhide/lengthmatters'
" Vundle
Plugin 'whatyouhide/lengthmatters'
```

You pathogen dinosaurs can just clone the repo:
``` bash
git clone https://github.com/whatyouhide/vim-lengthmatters.git ~/.vim/bundle
```


## What's in it

The highlighting functionality operates always on a **per-window** basis,
meaning you can keep it enabled on a window and disabled on another one at the
same time (think of splits, even both on the same file!).

By default, it's based on the value of the `textwidth` option (cool uh?), but
this can be changed in the options (see `:h 'textwidth'` for more infos).

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

##### `g:lengthmatters_on_by_default`

(defaults to `1`)  If this variable is set to `0`, no highlighting will be done
when opening a new buffer. Highlighting can still be activated with one of the
previously mentioned commands.

##### `g:lengthmatters_start_at_column`

(defaults to `81`)  
The value of this variable is the *first character* to be highlighted; the
highlighting will continue until the end of the line. This means that if it's
okay for lines to be `40` characters longm length of `40` characters (because
you're from 1920 or something) you set this variable to `41`.

##### `g:lengthmatters_use_textwidth`

(defaults to `1`)  
Whether to highlight based on the value of `textwidth`. If `textwidth` is not
set, it will fall back to `g:lengthmatters_start_at_column`.

##### `g:lengthmatters_excluded`

(defaults to
`['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m',
'nerdtree']`)  

A list of **filetypes** for which the highlighting isn't (and can't be) enabled.

##### `g:lengthmatters_match_name`

(defaults to `OverLength`)  
The name of the syntax element that will be used to highlight and match the
overly long lines.

##### `g:lengthmatters_colors`

(defaults to `ctermbg=lightgray guibg=darkgray`)  
By changing this value you can customize the colors of the highlighted parts.
This can be done also with the command:

``` viml
highlight [match-name] [colors]
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
[screenshot]: http://i.imgur.com/7lQRyRY.png "A screenshot of the plugin"
[vader]: https://github.com/junegunn/vader.vim
