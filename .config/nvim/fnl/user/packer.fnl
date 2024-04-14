(local packer (require :packer))

(packer.startup (fn [use]
                  (use :wbthomason/packer.nvim)
                  (use :rktjmp/hotpot.nvim)
                  (use :Evalir/dosbox-vim-colorscheme)
                  (use {1 :nvim-telescope/telescope.nvim
                        :branch :0.1.x
                        :requires [:nvim-lua/plenary.nvim]})
                  (use {1 :nvim-treesitter/nvim-treesitter :run ":TSUpdate"})
                  (use :Olical/conjure)
                  (use :gpanders/nvim-parinfer)
                  (use {1 :VonHeikemen/lsp-zero.nvim
                        :branch :v2.x
                        :requires [:neovim/nvim-lspconfig
                                   :williamboman/mason.nvim
                                   :williamboman/mason-lspconfig.nvim
                                   :jose-elias-alvarez/null-ls.nvim
                                   :jay-babu/mason-null-ls.nvim
                                   :hrsh7th/nvim-cmp
                                   :hrsh7th/cmp-nvim-lsp
                                   :PaterJason/cmp-conjure
                                   :hrsh7th/cmp-path
                                   :hrsh7th/cmp-buffer
                                   :hrsh7th/cmp-nvim-lsp-signature-help
                                   :hrsh7th/cmp-nvim-lua]})
                  (use :folke/trouble.nvim)
                  (use :tpope/vim-fugitive)
                  (use :lewis6991/gitsigns.nvim)
                  (use :numToStr/Comment.nvim)))
