-- bufferline: a VSCode-style tab strip showing open buffers.
-- Each "tab" here is actually a vim buffer. Closing one means closing that file.

-- Closes the current buffer without removing the window it was in.
-- Plain `:bdelete` also closes the window — which makes neo-tree expand
-- to fill the screen. This switches the window to another buffer first.
local function close_buffer_keep_layout()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.api.nvim_win_call(win, function()
      vim.cmd("bprevious")
      -- If we cycled back to the same buffer (no other listed buffers),
      -- replace it with a fresh empty one.
      if vim.api.nvim_get_current_buf() == bufnr then
        vim.cmd("enew")
      end
    end)
  end
  pcall(vim.api.nvim_buf_delete, bufnr, {})
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    -- Cycle through buffers
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },

    -- New empty buffer (save it later with `:w path/to/file`)
    { "<leader>bn", "<cmd>enew<cr>",                desc = "New buffer" },
    -- Close current buffer without collapsing the window into neo-tree
    { "<leader>bd", close_buffer_keep_layout,       desc = "Close buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer (sticks left)" },

    -- Direct jump by visual position. <C-N> works in modern terminals
    -- (Ghostty + kitty-keyboard-protocol supports it). If a number doesn't
    -- fire, your terminal isn't transmitting <C-N> — switch to <leader>N.
    { "<C-1>", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Buffer 1" },
    { "<C-2>", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Buffer 2" },
    { "<C-3>", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Buffer 3" },
    { "<C-4>", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Buffer 4" },
    { "<C-5>", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Buffer 5" },
    { "<C-6>", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Buffer 6" },
    { "<C-7>", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Buffer 7" },
    { "<C-8>", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Buffer 8" },
    { "<C-9>", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Buffer 9" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",        -- show LSP errors/warnings on each tab
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      -- Aligns the tabline so it doesn't overlap neo-tree's sidebar.
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
      numbers = "ordinal", -- show 1, 2, 3, ... so the <C-N> mapping is obvious
    },
  },
}
