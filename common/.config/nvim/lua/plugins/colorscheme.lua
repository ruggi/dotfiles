-- A plugin file returns a table (or list of tables) describing the plugin(s).
-- This is called a "plugin spec". lazy.nvim reads it and handles the rest.

return {
	"catppuccin/nvim", -- the plugin's GitHub repo (catppuccin/nvim)
	name = "catppuccin", -- folder name override (the repo is just "nvim", which is ambiguous)
	priority = 1000, -- load before every other plugin so the scheme applies first
	config = function()
		-- `config` runs after the plugin is loaded.
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
