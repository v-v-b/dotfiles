(module config.plugin.colorscheme
  {autoload {nvim aniseed.nvim}})

(set nvim.o.background :dark)
(set nvim.g.gruvbox_contrast_dark :hard)
(nvim.ex.colorscheme :gruvbox)
(nvim.ex.hi "Normal guibg=0")
(nvim.ex.hi "SignColumn guibg=0")
(nvim.ex.hi "ColorColumn guibg=gray6")
