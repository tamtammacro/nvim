local color_schemes = {"nightfox","poimandres","gruvbox","catppuccin"}

do
    local options = require "user.options"
    if options.lazy_plugins then require "user.lazyplugins" else require "user.plugins" end
end

require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keybinds"
require "user.modes"
require "user.usercommands"

vim.cmd.colorscheme(color_schemes[4])
