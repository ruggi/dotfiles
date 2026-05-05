-- Treesitter on the `main` branch (the actively maintained one for nvim 0.11+).
-- The API here is more bare-bones than `master`:
--   1. We tell it which parsers to install.
--   2. We turn highlighting on per-buffer via a FileType autocmd.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,            -- main branch wants eager-load so the FileType autocmd is ready
  build = ":TSUpdate",
  config = function()
    -- Install (or update) these parsers. `install` is idempotent and async.
    require("nvim-treesitter").install({
      "go",
      "typescript", "tsx", "javascript",
      "yaml", "json",
      "dockerfile",
      "terraform", "hcl",
      "lua", "vim", "vimdoc",
      "markdown", "markdown_inline",
      "bash", "regex",
    })

    -- Turn on treesitter for any buffer whose filetype has an installed parser.
    -- This replaces the old `highlight = { enable = true }` config option.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf) -- silently no-op if parser missing
      end,
    })
  end,
}
