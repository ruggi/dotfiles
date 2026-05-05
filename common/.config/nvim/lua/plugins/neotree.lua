-- Neo-tree: a sidebar file explorer (the VSCode-style left pane).

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",  -- pin to the v3 line; the project moves fast on main
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- file-type icons (needs a Nerd Font — you have one)
    "MunifTanjim/nui.nvim",        -- generic UI library used by neo-tree
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        -- Count non-neotree windows in the current tab. If there are none,
        -- neo-tree would open as the full screen ("maximized") — so spawn
        -- a fresh editing window first.
        local edit_wins = 0
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= "neo-tree" then
            edit_wins = edit_wins + 1
          end
        end
        if edit_wins == 0 then
          vim.cmd("vnew") -- creates a new vertical split with an empty buffer
        end
        vim.cmd("Neotree toggle")
      end,
      desc = "File explorer",
    },
  },
  -- `opts = { ... }` is shorthand: lazy will call `require("neo-tree").setup(opts)` for us.
  opts = {
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the file you're editing
      use_libuv_file_watcher = true,            -- auto-refresh when files change on disk
    },
    window = { width = 32 },
  },
}
