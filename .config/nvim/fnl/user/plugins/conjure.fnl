(let [api vim.api]
  (set vim.g.conjure#client_on_load false)
  (set vim.g.conjure#mapping#doc_word :gk)
  ;(set vim.g.conjure#debug true)
  (set vim.g.conjure#client#sql#stdio#command
       (.. :sh " " (vim.fn.getcwd) :/local-psql))
  (when (= 1 (vim.fn.filereadable (.. (vim.fn.getcwd) :/.love2d)))
    (set vim.g.conjure#filetype#fennel :conjure.client.fennel.stdio)
    (set vim.g.conjure#client#fennel#stdio#command "love ."))
  (api.nvim_create_autocmd :FileType
                           {:callback (fn []
                                        (set vim.b.conjure#eval#gsubs
                                             {:do [".+" "%1;"]}))
                            :group (api.nvim_create_augroup :FtOpts
                                                            {:clear true})
                            :pattern [:sql]})
  (api.nvim_create_autocmd :BufNewFile
                           {:callback (fn []
                                        (vim.diagnostic.disable 0))
                            :group (api.nvim_create_augroup :lsp_disable
                                                            {:clear true})
                            :pattern [:conjure-log-*]}))
