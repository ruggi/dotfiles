-- blink.cmp: autocomplete engine. Modern, fast, less config than nvim-cmp.

return {
  "saghen/blink.cmp",
  -- `version = "*"` pulls the latest tagged release, which ships a pre-built
  -- binary so we don't need a Rust toolchain locally.
  version = "*",
  event = "InsertEnter",
  opts = {
    -- Default keymap preset:
    --   <C-space> open menu, <C-e> cancel,
    --   <C-n>/<C-p> next/prev, <C-y> accept,
    --   <Tab>/<S-Tab> snippet jump.
    -- We add Enter-to-accept on top — feels familiar coming from VSCode.
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      -- Tells blink which Nerd Font variant you're using so icons align.
      -- JetBrains Mono Nerd Font is the "mono" variant.
      nerd_font_variant = "mono",
    },

    sources = {
      -- Where completion items come from. Order = priority (LSP first).
      default = { "lsp", "path", "snippets", "buffer" },
    },

    completion = {
      -- Show docs panel next to the menu after a small delay.
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
  },
}
