Just a personal .vimrc file to help me have my vim set up no matter where I am.

To use it with neovim it should be enough with adding

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```
to `~/.config/nvim/init.vim`.
