-- Bootstrap lazy.nvim: clone it on first run, then add it to runtime path.
-- This block is copy-pasted from the lazy.nvim docs and rarely needs editing.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from lua/plugins/.
-- `{ import = "plugins" }` tells lazy to scan that directory and import every file.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Show this colorscheme while plugins are installing on first launch.
  install = { colorscheme = { "catppuccin-mocha", "habamax" } },
  -- Periodically check for plugin updates (silent — no popups).
  checker = { enabled = true, notify = false },
})
