(let [lsp (require :lsp-zero)
      mnl (require :mason-null-ls)
      nl (require :null-ls)
      cmp (require :cmp)
      ks vim.keymap.set]
  (lsp.preset {})
  (lsp.on_attach (fn [client buf]
                   (lsp.default_keymaps {:buffer buf})
                   (ks :n :<localleader>f vim.lsp.buf.format {:buffer true})
                   (ks :v :<localleader>f vim.lsp.buf.format {:buffer true})))
  (lsp.setup)
  (nl.setup {:sources [nl.builtins.formatting.fnlfmt
                       (nl.builtins.diagnostics.eslint.with {:prefer_local :node_modules/.bin})
                       (nl.builtins.diagnostics.stylelint.with {:prefer_local :node_modules/.bin})
                       (nl.builtins.formatting.prettier.with {:prefer_local :node_modules/.bin})]})
  (mnl.setup {:handlers {}})
  (cmp.setup {:preselect :item
              :completion {:completeopt ":menu,menuone,noinsert"}
              :sources [{:name :nvim_lsp}
                        {:name :conjure}
                        {:name :path}
                        {:name :buffer}
                        {:name :nvim_lsp_signature_help}
                        {:name :nvim_lua}]}))
