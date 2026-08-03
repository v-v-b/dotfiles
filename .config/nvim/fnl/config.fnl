(fn configure [target settings]
  (each [key value (pairs settings)]
    (set (. target key) value)))

(vim.pack.add ["https://github.com/bettervim/yugen.nvim"
               "https://github.com/romus204/tree-sitter-manager.nvim"
               "https://github.com/Olical/conjure"
               "https://github.com/hrsh7th/nvim-cmp"
               "https://github.com/PaterJason/cmp-conjure"
               "https://github.com/hrsh7th/cmp-nvim-lsp"
               "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
               "https://github.com/hrsh7th/cmp-buffer"
               "https://github.com/hrsh7th/cmp-path"
               "https://github.com/neovim/nvim-lspconfig"
               "https://github.com/mason-org/mason.nvim"
               "https://github.com/mason-org/mason-lspconfig.nvim"
               "https://github.com/nvim-lua/plenary.nvim"
               "https://github.com/nvimtools/none-ls.nvim"
               "https://github.com/ibhagwan/fzf-lua"
               "https://github.com/julienvincent/nvim-paredit"])

(vim.schedule #(vim.opt.clipboard:append :unnamedplus))

(configure vim.g {:mapleader " "
                  :maplocalleader ","
                  :netrw_banner 0
                  :netrw_liststyle 3
                  "conjure#mapping#doc_word" :gk})

(configure vim.opt {:termguicolors true
                    :wrap false
                    :relativenumber true
                    :colorcolumn :80
                    :signcolumn "yes:1"
                    :pumheight 5
                    :cmdheight 0
                    :shiftwidth 2
                    :softtabstop -1
                    :expandtab true
                    :splitright true
                    :splitbelow true
                    :ignorecase true
                    :smartcase true
                    :list true
                    :listchars {:eol "¬" :tab "■■" :trail "█" :nbsp "+"}
                    :swapfile false
                    :writebackup false})

(vim.cmd.colorscheme :yugen)
(vim.api.nvim_set_hl 0 :ColorColumn {:bg "#101010"})

((. (require :tree-sitter-manager) :setup) {:nerdfont false})
((. (require :nvim-paredit) :setup) {})

(let [fzf (require :fzf-lua)
      map #(vim.keymap.set :n $1 $2 {:silent true :desc $3})]
  (fzf.setup {:grep {:rg_opts (.. "--hidden --glob='!.git/**' "
                                  fzf.config.defaults.grep.rg_opts)}})
  (map :<leader>ff #(fzf.files) "Find files")
  (map :<leader>fg #(fzf.live_grep) "Live grep")
  (map :<leader>fb #(fzf.buffers) :Buffers)
  (map :<leader>fr #(fzf.resume) "Resume search"))

(let [cmp (require :cmp)]
  (cmp.setup {:mapping (cmp.mapping.preset.insert {})
              :sources [{:name :conjure}
                        {:name :nvim_lsp}
                        {:name :nvim_lsp_signature_help}
                        {:name :buffer}
                        {:name :path}]}))

(vim.lsp.config "*"
                {:capabilities ((. (require :cmp_nvim_lsp)
                                   :default_capabilities))})

((. (require :mason) :setup) {})
((. (require :mason-lspconfig) :setup) {})

(let [nl (require :null-ls)]
  (nl.setup {:sources [nl.builtins.formatting.fnlfmt]}))

(fn lsp-keymap [event]
  (let [map #(vim.keymap.set $1 $2 $3 {:buffer event.buf :silent true :desc $4})]
    (map :n :gd vim.lsp.buf.definition "LSP: definition")
    (map [:n :v] :<leader>f
         #(vim.lsp.buf.format {:async true :bufnr event.buf}) "LSP: format")
    (map :n :<leader>d vim.diagnostic.open_float "Diagnostics: current line")))

(vim.api.nvim_create_autocmd :LspAttach {:callback lsp-keymap})
