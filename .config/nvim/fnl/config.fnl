(each [k v (pairs {:mapleader " "
                   :maplocalleader ","
                   :netrw_banner 0
                   :netrw_liststyle 3})]
  (tset vim.g k v))

(each [k v (pairs {:termguicolors true
                   :wrap false
                   :relativenumber true
                   :colorcolumn :80
                   :pumheight 5
                   :shiftwidth 2
                   :tabstop 2
                   :softtabstop 2
                   :expandtab true
                   :splitright true
                   :splitbelow true
                   :ignorecase true
                   :smartcase true
                   :list true
                   :listchars "eol:¬,tab:■■,trail:█"
                   :swapfile false
                   :backup false
                   :writebackup false})]
  (tset vim.opt k v))

(vim.schedule (fn [] (set vim.opt.clipboard :unnamedplus)))

(let [vks vim.keymap.set
      vd vim.diagnostic
      vlb vim.lsp.buf
      callback (fn [{:buf buffer}]
                 (vks :n :gd vlb.definition {: buffer})
                 (vks :n :gD vlb.declaration {: buffer})
                 (vks :n :gi vlb.implementation {: buffer})
                 (vks :n :gr vlb.references {: buffer})
                 (vks :n :<leader>of vd.open_float {: buffer})
                 (vks :n :<leader>ca vlb.code_action {: buffer})
                 (vks :n :<leader>rn vlb.rename {: buffer})
                 (vks [:n :v] :<leader>ws vlb.workspace_symbol {: buffer})
                 (vks [:n :v] :<localleader>f vlb.format {: buffer}))]
  (vim.api.nvim_create_autocmd :LspAttach {: callback}))

(let [lazy (require :lazy)]
  (lazy.setup [:rktjmp/hotpot.nvim
               {1 :bettervim/yugen.nvim
                :init (fn []
                        (vim.cmd.colorscheme :yugen)
                        (vim.cmd.hi "colorcolumn guibg=#101010"))}
               {1 :nvim-treesitter/nvim-treesitter
                :build ":TSUpdate"
                :main :nvim-treesitter.configs
                :opts {:auto_install true
                       :sync_install false
                       :indent {:enable true}
                       :highlight {:enable true
                                   :additional_vim_regex_highlighting false}}}
               {1 :Olical/conjure
                :dependencies [:PaterJason/cmp-conjure]
                :init (fn []
                        ;(set vim.g.conjure#debug true)
                        (set vim.g.conjure#client_on_load false)
                        (set vim.g.conjure#mapping#doc_word :gk)
                        (when (vim.uv.fs_stat (.. (vim.fn.getcwd) :/.love2d))
                          (set vim.g.conjure#filetype#fennel
                               :conjure.client.fennel.stdio)
                          (set vim.g.conjure#client#fennel#stdio#command
                               "love ."))
                        (set vim.g.conjure#client#sql#stdio#command
                             (.. :sh " " (vim.fn.getcwd) :/local-psql)))}
               {1 :hrsh7th/nvim-cmp
                :event :InsertEnter
                :dependencies [:hrsh7th/cmp-nvim-lsp
                               :hrsh7th/cmp-path
                               :hrsh7th/cmp-buffer
                               :hrsh7th/cmp-nvim-lsp-signature-help]
                :config (fn []
                          (let [cmp (require :cmp)]
                            (cmp.setup {:snippet {:expand (fn [{: body}]
                                                            (vim.snippet.expand body))}
                                        :mapping (cmp.mapping.preset.insert {})
                                        :sources (cmp.config.sources [{:name :nvim_lsp}
                                                                      {:name :nvim_lsp_signature_help}
                                                                      {:name :path}
                                                                      {:name :conjure}]
                                                                     [{:name :buffer}])})))}
               {1 :neovim/nvim-lspconfig
                :dependencies [{1 :williamboman/mason.nvim :config true}
                               :williamboman/mason-lspconfig.nvim
                               :nvimtools/none-ls.nvim
                               :nvim-lua/plenary.nvim
                               :jay-babu/mason-null-ls.nvim]
                :config (fn []
                          (let [lsp (require :lspconfig)
                                m (require :mason)
                                ml (require :mason-lspconfig)
                                nl (require :null-ls)
                                mnl (require :mason-null-ls)
                                capabilities ((. (require :cmp_nvim_lsp)
                                                 :default_capabilities))]
                            (m.setup)
                            (ml.setup {:handlers [(fn [server]
                                                    ((. lsp server :setup) {: capabilities}))]})
                            (mnl.setup {:handlers {}})
                            (nl.setup {:sources [nl.builtins.formatting.fnlfmt]})))}]))
