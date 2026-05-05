-- conform.nvim: format files using whichever formatter is right for the language.
-- Each formatter is just a binary on PATH; install via :Mason or your usual toolchain.

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },          -- load right before the first save
  cmd = { "ConformInfo" },             -- :ConformInfo shows what conform sees for the buffer
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true }) end,
      desc = "Format buffer",
    },
  },
  opts = {
    -- For each filetype: a list of formatters to try.
    -- `stop_after_first = true` means: use the first one that's installed.
    formatters_by_ft = {
      go              = { "goimports", "gofmt" },                              -- both run, gofmt after goimports
      typescript      = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      javascript      = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      json            = { "prettierd", "prettier", stop_after_first = true },
      yaml            = { "prettierd", "prettier", stop_after_first = true },
      markdown        = { "prettierd", "prettier", stop_after_first = true },
      terraform       = { "terraform_fmt" },
      lua             = { "stylua" },
    },

    -- Format on save. Returning the table enables it; nil disables.
    format_on_save = function(bufnr)
      -- Escape hatches: per-buffer or global toggle to skip auto-format.
      if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" } -- LSP formatter as last resort
    end,
  },
}
