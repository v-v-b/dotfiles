local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/'

local function ensure_installed(plugin_ref)
  local plugin_name = vim.split(plugin_ref, '/')[2]
  local install_path = packer_install_path .. plugin_name

  if vim.loop.fs_stat(install_path) then return end

  vim.fn.system({ 'git', 'clone',
    'https://github.com/' .. plugin_ref, install_path })
  vim.cmd.packadd(plugin_name)
end

ensure_installed('rktjmp/hotpot.nvim')
ensure_installed('wbthomason/packer.nvim')

require("hotpot")
require("user")
