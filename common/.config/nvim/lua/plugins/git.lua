-- Git tooling stack:
--   gitsigns  -- always-on gutter signs + per-hunk staging/preview/reset
--   diffview  -- side-by-side diff with a changed-files panel (the VSCode git pane)
--   lazygit   -- full TUI (stage/commit/branch/push); needs the `lazygit` binary

return {
  -- gutter signs: shows +/-/~ in the sign column for added/changed/removed lines.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      -- Buffer-local keymaps: only set inside files where gitsigns has attached.
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end

        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "<leader>gp", gs.preview_hunk,                       "Preview hunk")
        map("n", "<leader>gs", gs.stage_hunk,                         "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk,                         "Reset hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  -- diffview: VSCode-style git panel (file list + side-by-side diff, editable).
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Git: diff view (working tree)" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Git: close diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git: history (current file)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Git: history (all files)" },
    },
    opts = {},
  },

  -- lazygit: launches the standalone `lazygit` TUI in a floating window.
  -- Requires the lazygit binary on PATH: `brew install lazygit`.
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit (full TUI)" },
    },
  },
}
