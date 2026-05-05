-- Telescope: fuzzy finder over files, buffers, grep results, LSP symbols, etc.

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- fzf-native: a C-compiled sorter that makes fuzzy matching much faster.
    -- `build = "make"` runs that command after the plugin is installed/updated.
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  -- `cmd` and `keys` make this plugin lazy-loaded:
  -- it only loads when you run `:Telescope ...` or press one of these keys.
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep (project)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (problems)" },
  },
  config = function()
    require("telescope").setup({})
    -- Activate the fzf extension after setup so telescope uses the fast sorter.
    pcall(require("telescope").load_extension, "fzf")
  end,
}
