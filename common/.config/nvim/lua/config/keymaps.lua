-- Keymaps. `vim.keymap.set(mode, lhs, rhs, opts)` is the modern API.
-- Modes: "n" = normal, "i" = insert, "v" = visual, "x" = visual-only (no select), "t" = terminal.

-- Leader key: pressing <Space> acts as a "prefix" for our custom commands.
-- MUST be set BEFORE any mapping that uses <leader>, hence we set it first.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- File ops
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>",  { desc = "Quit window" })

-- Plugin manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy plugin manager" })

-- Clear search highlight (only matters once we re-enable hlsearch later, but harmless)
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation: Ctrl + h/j/k/l to move between splits
map("n", "<C-h>", "<C-w>h", { desc = "Window: left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: right" })

-- Create splits: leader + symbol that visually matches the split direction
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical (new pane right)" })
map("n", "<leader>-", "<cmd>split<cr>",  { desc = "Split horizontal (new pane below)" })

-- Like :only but spares neo-tree: closes every other editing window in the tab.
map("n", "<leader>o", function()
  local current = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= current then
      local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
      if ft ~= "neo-tree" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
end, { desc = "Only this window (keep neo-tree)" })

-- Keep cursor centered when jumping half-pages (small quality of life)
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Toggle comments with <C-/> (VSCode-style). nvim 0.10+ ships gcc/gc built-in;
-- we just remap to those. Some terminals deliver <C-/> as <C-_>, so bind both.
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment line" })
map("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
map("x", "<C-/>", "gc",  { remap = true, desc = "Toggle comment selection" })
map("x", "<C-_>", "gc",  { remap = true, desc = "Toggle comment selection" })
