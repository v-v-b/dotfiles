(module config.plugin.easy-align
  {autoload {nvim aniseed.nvim}})

(nvim.ex.nmap "ga <Plug>(EasyAlign)")
(nvim.ex.xmap "ga <Plug>(EasyAlign)")
