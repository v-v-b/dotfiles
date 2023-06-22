(module config.plugin.cmp
  {autoload {cmp cmp
             nvim aniseed.nvim}})

(set nvim.o.completeopt "menuone,noselect")

(defn- format [entry item]
  (set item.menu
       (or (. {:buffer   :bfr
               :nvim_lsp :lsp
               :conjure  :cnj}
              entry.source.name)
           ""))
  item)

(cmp.setup {:formatting {:format format}
            :sources [{:name :nvim_lsp}
                      {:name :conjure}
                      {:name :buffer}]
            :mapping {:<C-p> (cmp.mapping.select_prev_item)
                      :<C-n> (cmp.mapping.select_next_item)
                      :<C-b> (cmp.mapping.scroll_docs -4)
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.abort)
                      :<C-CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                    :select true})}})
