(let [t (require :telescope.builtin)
      ks vim.keymap.set]
  (ks :n :<leader>ff t.find_files {})
  (ks :n :<leader>fb t.buffers {})
  (ks :n :<leader>fw t.grep_string {})
  (ks :v :<leader>fw t.grep_string {})
  (ks :n :<leader>gf t.git_files {})
  (ks :n :<leader>gs t.live_grep {}))
