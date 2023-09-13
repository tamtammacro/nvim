local color_schemes = {"nightfox","poimandres","gruvbox","catppuccin", "vscode"}

local options = require "user.options"

if options.lazy_plugins then require "user.lazyplugins" else require "user.plugins" end

require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keybinds"
require "user.modes"
require "user.usercommands"
require "user.discord_presence"

vim.cmd.colorscheme(color_schemes[#color_schemes])

if options.no_background then
    vim.cmd["highlight"]("Normal guibg=none")
end
