(module config.plugin.colorscheme
  {autoload {nvim aniseed.nvim}})

(set nvim.o.background :dark)
(set nvim.g.gruvbox_contrast_dark :hard)
(set nvim.g.gruvbox_sign_column :none)
(nvim.ex.colorscheme :gruvbox)
(nvim.ex.hi "Normal guibg=0")
(nvim.ex.hi "VertSplit guibg=0")
(nvim.ex.hi "NormalFloat guibg=0")
;;(nvim.ex.hi "SignColumn guibg=0 ctermbg=0")
(nvim.ex.hi "ColorColumn guibg=gray6")

(nvim.ex.au "BufReadPost *.rkt,*.rktl set filetype=racket")

(def lsp_grp
  (vim.api.nvim_create_augroup "lsp_disable" {:clear true}))

(vim.api.nvim_create_autocmd
  ["BufEnter" "BufNewFile"]
  {:group lsp_grp
   :pattern ["conjure-log-*"]
   :callback (fn [] (vim.diagnostic.disable 0))})

