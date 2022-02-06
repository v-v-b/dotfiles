(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope}})

(nvim.set_keymap :n :<leader>ff  ":Telescope find_files hidden=true<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fg  ":Telescope git_files hidden=true<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>ft  ":Telescope file_browser hidden=true<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb  ":Telescope buffers<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fla ":Telescope lsp_code_actions<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fli ":Telescope lsp_implementations<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>flr ":Telescope lsp_references<CR>" {:noremap true})

(telescope.load_extension :file_browser)
