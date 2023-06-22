(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup
  {;:ensure_installed :all
   ;:ignore_install ["phpdoc"]
   :indent {:enable true}
   :highlight {:enable true
               :additional_vim_regex_highlighting false}})

