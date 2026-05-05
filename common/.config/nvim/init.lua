-- Entry point. Neovim runs this file on startup.
-- All it does is load the modules under lua/config/.

require("config.options")
require("config.keymaps")  -- sets leader key — must run before lazy
require("config.lazy")     -- loads all plugins from lua/plugins/
require("config.autocmds") -- VimEnter behavior, etc.
