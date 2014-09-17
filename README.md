# lengthmatters.vim

Highlight the part of a line that goes over the 80th (or whatever you like)
column.

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

This plugin offers some fancier functionality than just coloring lines that are
too long:

- `:LengthmattersToggle`: toggle the highlighting functionality on a
    **per-buffer** basis, meaning you can keep it enabled on a buffer and
    disabled on another one at the same time.
- A bunch of easily guess-what-they-do functions to use in whatever way you find
    appropriate:
    * `LengthmattersToggle()`
    * `LengthmattersDisable()`
    * `LengthmattersEnable()`

## Configuration

To set a variable in vim (for example `g:foo` to the string `foo`), just do:

``` viml
let g:foo = 'foo'
```

##### `g:lengthmatters_on_by_default`

(defaults to `1`)  
If this variable is set to `0`, no highlighting will be done when opening a new
buffer. Highlighting can still be activated with `:LengthmattersToggle` or
through calling one of the previously mentioned functions.

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

##### `g:lengthmatters_start_at_column`

(defaults to `81`)  
The value of this variable is the *first character* to be highlighted; the
highlighting will continue until the end of the line. This means that if it's
okay for lines to be `40` characters longm length of `40` characters (because
you're from 1920 or something) you set this variable to `41`.


## License

&copy; Andrea Leopardi

[![][wtfpl-logo]][wtfpl]

[vundle]: https://github.com/gmarik/Vundle.vim
[vim-plug]: https://github.com/junegunn/vim-plug
[wtfpl]: http://www.wtfpl.net/
[wtfpl-logo]: http://www.wtfpl.net/wp-content/uploads/2012/12/logo-220x1601.png
