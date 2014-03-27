# vim-dependencywtf

Find out what the fuck that dependency is.

![Example](https://s3.amazonaws.com/f.cl.ly/items/2H3R070V0w0Z2P2F3R0p/animated-2014-03-27_17h-13m-56s.gif)

## Installation

Recommended installation with [Vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'tsigo/vim-dependencywtf'
```

## Supported package managers

* [Bundler](http://bundler.io/) - `gem "rails", '4.0.0'`
* [RubyGems](https://rubygems.org/) - `s.add_dependency 'activesupport', [">= 4.0.0"]`
* [Vundle](https://github.com/gmarik/Vundle.vim) - `Plugin "tpope/rails.vim"`

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
map <Leader>dw :call DependencyWTF()<CR>
```

## Credits

## License

vim-dependencywtf is copyright © 2014 Robert Speicher. It is free software, and
may be redistributed under the terms specified in the `LICENSE` file.
