-- Autocmds = "do X when event Y happens." Vim has dozens of events
-- (file opened, file saved, mode changed, leaving insert, etc.).

-- Re-balance splits when the terminal (or font size) changes.
-- `wincmd =` makes splits roughly equal, applied across every tab.
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab) -- `tabdo` jumps tabs; restore focus
  end,
  desc = "Equalize splits on terminal resize",
})

-- Behavior on launch:
--   nvim                  → open neo-tree at the current directory
--   nvim ~/some-folder    → cd into it, then open neo-tree
--   nvim file.go          → open the file as normal (no tree)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- No args: just open the explorer at cwd.
    if vim.fn.argc() == 0 then
      vim.cmd("Neotree focus")
      return
    end

    -- One arg that's a directory: cd into it and open the explorer there.
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      local stat = (vim.uv or vim.loop).fs_stat(arg)
      if stat and stat.type == "directory" then
        vim.cmd.cd(arg)
        vim.cmd("enew")          -- replace nvim's auto-opened directory buffer
        vim.cmd("Neotree focus")
      end
    end
  end,
})
