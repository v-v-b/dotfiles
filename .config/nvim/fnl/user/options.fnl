(let [globals {:mapleader " "
               :maplocalleader ","
               :netrw_banner 0
               :netrw_liststyle 3}]
  (each [glob val (pairs globals)]
    (tset vim.g glob val)))

(let [opts {:termguicolors true
            :wrap false
            :relativenumber true
            :colorcolumn :80
            :shiftwidth 2
            :tabstop 2
            :softtabstop 2
            :expandtab true
            :splitright true
            :splitbelow true
            :list true
            :listchars "eol:¬,tab:■■,trail:█"
            :swapfile false
            :backup false
            :writebackup false}]
  (each [opt val (pairs opts)]
    (tset vim.opt opt val)))
