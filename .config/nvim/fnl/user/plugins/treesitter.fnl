(let [t (require :nvim-treesitter.configs)]
  (t.setup {:auto_install true
            :highlight {:additional_vim_regex_highlighting false :enable true}
            :sync_install false}))
