(let [ks vim.keymap.set]
  (each [_ mode (pairs [:n :i :v :x])]
    (each [_ key (pairs [:<Up> :<Down> :<Left> :<Right>])]
      (ks mode key :<nop>))))
