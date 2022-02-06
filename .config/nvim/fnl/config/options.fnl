(module config.options
  {autoload {core aniseed.core
             nvim aniseed.nvim}})

(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(let [options
      {:termguicolors true ;; Use true colors
       :ignorecase true    ;; Case insensitive search
       :smartcase true     ;; ... but case sensitive when uc present
       :wrap false         ;; Do not wrap long lines
       :shiftwidth 2       ;; Use indents of 2 spaces
       :tabstop 2          ;; An indentation every four columns
       :softtabstop 2      ;; Let backspace delete indent
       :expandtab true     ;; Tabs are spaces, not tabs
       :splitright true    ;; Puts new vsplit windows to the right
       :splitbelow true    ;; Puts new split windows to the bottom
       :list true          ;; List on
       :listchars "eol:¬,tab:■■,trail:█"
       :backup false       ;; No swap/backups
       :swapfile false
       :writebackup false
       :mouse :a           ;; Enable mouse
       :relativenumber true;; Relative numbers
       :signcolumn :number ;; Signs in the number column
       :colorcolumn :80}]  ;; Highlight column
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))
