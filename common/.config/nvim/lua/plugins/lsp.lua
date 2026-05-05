-- LSP stack — modernized for neovim 0.11+ (`vim.lsp.config` / `vim.lsp.enable`).
--
-- Roles:
--   mason             -- installs LSP server binaries on demand
--   mason-lspconfig   -- declares which servers should be installed + auto-enabled
--   nvim-lspconfig    -- ships default per-server configs (cmd, filetypes, root markers)
--                        which `vim.lsp.config` reads automatically. We don't `require` it.

return {
	{
		"williamboman/mason.nvim",
		opts = {}, -- runs require("mason").setup({}) for us
	},

	-- We don't configure mason-lspconfig here — see nvim-lspconfig's config function below.
	{ "williamboman/mason-lspconfig.nvim" },

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp", -- so we can pull completion-aware capabilities
		},
		config = function()
			-- How diagnostics (errors/warnings) appear globally:
			--   virtual_text: ghost text at end of line with the message
			--   float: a popup we trigger on demand (see <leader>d below)
			vim.diagnostic.config({
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
			})

			-- Capabilities advertise client features (snippet support, etc.) to servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- "*" is a wildcard: applies to every server we enable below.
			vim.lsp.config("*", { capabilities = capabilities })

			-- Per-server overrides. nvim-lspconfig's defaults are merged in automatically.
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- mason-lspconfig 2.x with `automatic_enable = true` calls `vim.lsp.enable()`
			-- for every installed server, picking up our `vim.lsp.config()` above.
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls", -- Go
					"terraformls", -- Terraform
					"lua_ls", -- Lua (handy for editing this config!)
					-- Need node/npm — uncomment after `brew install node`:
					"ts_ls", -- TypeScript / JavaScript / TSX
					"yamlls", -- YAML
					"dockerls", -- Dockerfile
				},
				automatic_enable = true,
			})

			-- Buffer-local LSP keymaps: only set when an LSP attaches to a buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "K", vim.lsp.buf.hover, "Hover docs")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic at cursor")
					-- vim.diagnostic.jump is the modern replacement for goto_prev/goto_next.
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Prev diagnostic")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")
				end,
			})
		end,
	},
}
