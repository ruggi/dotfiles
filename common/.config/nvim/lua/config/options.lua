-- Vim options. `vim.opt` is the modern Lua API for `:set`.
local opt = vim.opt

-- Line numbers
opt.number = true          -- show absolute line numbers

-- Indentation: 2 spaces, expanded from tabs
opt.tabstop = 2            -- a <Tab> character displays as 2 spaces
opt.shiftwidth = 2         -- >> and << shift by 2 spaces
opt.expandtab = true       -- pressing <Tab> inserts spaces, not a tab character
opt.smartindent = true     -- auto-indent new lines based on syntax

-- Search
opt.ignorecase = true      -- case-insensitive search...
opt.smartcase = true       -- ...unless the query has uppercase letters
opt.incsearch = true       -- highlight matches as you type
opt.hlsearch = false       -- don't keep matches highlighted after search

-- Files / undo
opt.swapfile = false       -- no .swp files cluttering directories
opt.backup = false         -- no ~ backup files
opt.undofile = true        -- persistent undo across sessions (stored in ~/.local/state/nvim/undo)

-- UI
opt.termguicolors = true   -- enable 24-bit color (required by most colorschemes)
opt.signcolumn = "yes"     -- always show the gutter column (prevents text jumping when LSP/git signs appear)
opt.scrolloff = 8          -- keep 8 lines visible above/below the cursor when scrolling
opt.cursorline = true      -- highlight the current line
opt.wrap = true            -- wrap long lines visually
opt.linebreak = true       -- when wrapping, break at word boundaries (not mid-word)
opt.breakindent = true     -- wrapped lines keep the original indentation
opt.splitright = true      -- vertical splits open to the right
opt.splitbelow = true      -- horizontal splits open below

-- Misc
opt.clipboard = "unnamedplus" -- use the system clipboard for yank/paste
opt.updatetime = 250          -- faster CursorHold events (used by LSP later)
opt.timeoutlen = 400          -- shorter wait for mapped key sequences
