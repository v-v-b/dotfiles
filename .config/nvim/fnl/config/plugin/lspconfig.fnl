(module config.plugin.lspconfig
  {autoload {nvim aniseed.nvim
             nl null-ls
             cnl cmp_nvim_lsp
             li nvim-lsp-installer}})

(defn- set-keymaps [buf]
  (do
    (nvim.buf_set_keymap buf :n :K ":lua vim.lsp.buf.hover()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :gd ":lua vim.lsp.buf.definition()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :gD ":lua vim.lsp.buf.declaration()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :gi ":lua vim.lsp.buf.implementation()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :gr ":lua vim.lsp.buf.references()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<leader>lt ":lua vim.lsp.buf.type_definition()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<leader>lr ":lua vim.lsp.buf.rename()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<leader>lf ":lua vim.diagnostic.open_float()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<leader>lq ":lua vim.diagnostic.setloclist()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<localleader>ff ":lua vim.lsp.buf.formatting()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :v :<localleader>ff ":lua vim.lsp.buf.range_formatting()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<c-k> ":lua vim.lsp.buf.signature_help()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<c-n> ":lua vim.diagnostic.goto_next()<cr>" {:noremap true})
    (nvim.buf_set_keymap buf :n :<c-p> ":lua vim.diagnostic.goto_prev()<cr>" {:noremap true})))

(defn- set-formatters [client]
  (when (= client.name :tsserver)
    (set client.resolved_capabilities.document_formatting false)
    (set client.resolved_capabilities.document_range_formatting false)))

(nl.setup
  {:sources [(nl.builtins.diagnostics.eslint.with    {:prefer_local :node_modules/.bin})
             (nl.builtins.diagnostics.stylelint.with {:prefer_local :node_modules/.bin})
             (nl.builtins.formatting.prettier.with   {:prefer_local :node_modules/.bin})]})

(li.on_server_ready
  (fn [srv]
    (srv:setup {:capabilities (cnl.update_capabilities
                                (vim.lsp.protocol.make_client_capabilities))
                :on_attach (fn [client bufnr]
                             (do
                               (set-formatters client)
                               (set-keymaps bufnr)))})))
