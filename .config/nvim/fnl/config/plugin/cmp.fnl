(module config.plugin.cmp
  {autoload {cmp cmp}})

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
                      {:name :buffer}]})
