" === Theme Config ===
syntax enable

set background=dark
set termguicolors

if (!has("nvim"))
  set term=xterm-256color
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

color one
