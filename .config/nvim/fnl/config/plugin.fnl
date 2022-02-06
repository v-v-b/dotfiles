(module config.plugin
  {autoload {nvim aniseed.nvim
             core aniseed.core
             packer packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn- use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (core.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (core.assoc opts 1 name)))))))
  nil)

(use
  :wbthomason/packer.nvim {}
  :Olical/aniseed {:branch :develop}
  :lewis6991/impatient.nvim {}

  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :williamboman/nvim-lsp-installer {}
  :jose-elias-alvarez/null-ls.nvim {:requires [:nvim-lua/plenary.nvim]}

  :nvim-telescope/telescope-file-browser.nvim {}
  :nvim-telescope/telescope.nvim {:mod :telescope
                                  :requires [:nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]}

  :hrsh7th/nvim-cmp {:mod :cmp
                     :requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :PaterJason/cmp-conjure]}

  :Olical/conjure {}
  :clojure-vim/vim-jack-in {:requires [:tpope/vim-dispatch
                                       :radenling/vim-dispatch-neovim]}

  :lewis6991/gitsigns.nvim {:mod :gitsigns}

  :gruvbox-community/gruvbox {:mod :colorscheme}
  :nvim-lualine/lualine.nvim {:mod :statusline})
