-- Claude Code: IDE-style integration with the `claude` CLI.
-- Sends selections/files as context, streams proposed edits as diffs you
-- accept or reject inside nvim — same flow as the VSCode extension.
--
-- Prereqs: `claude` CLI installed and authenticated.
-- snacks.nvim is pulled in automatically as a dep.

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Claude: toggle window" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Claude: focus window" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Claude: send selection", mode = "v" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Claude: accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Claude: reject diff" },
  },
}
