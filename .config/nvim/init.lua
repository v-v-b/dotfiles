local function ensure_installed(plugin, branch)
  local repo = vim.split(plugin, '/')[2]
  local path = vim.fn.stdpath('data') .. '/lazy/' .. repo

  if not (vim.uv or vim.loop).fs_stat(path) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=' .. branch,
      'https://github.com/' .. plugin .. '.git',
      path
    })
  end

  return path
end

vim.opt.runtimepath:prepend({
  ensure_installed('rktjmp/hotpot.nvim', 'v0.14.7'),
  ensure_installed('folke/lazy.nvim', 'stable')
})

vim.loader.enable()

require ('hotpot')
require('config')

