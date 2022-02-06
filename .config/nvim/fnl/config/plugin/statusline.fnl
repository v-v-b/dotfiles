(module config.plugin.statusline
  {autoload {lualine lualine}})

(lualine.setup {:options {:theme "gruvbox-material"
                          :section_separators ""
                          :component_separators ""}})
