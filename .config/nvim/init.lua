-- ref https://github.com/Olical/dotfiles

-- neovim config entrypoint,
-- bootstraps packer and aniseed
-- to compile and load fnl/init.fnl.

local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")
ensure("lewis6991", "impatient.nvim")

-- pre-compile and cache lua modules
require("impatient")

-- compile and load fennel modules
vim.g["aniseed#env"] = {
  module = "config.init",
  compile = true
}

