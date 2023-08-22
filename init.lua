local color_schemes = {"nightfox","poimandres","gruvbox","catppuccin"}

require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keybinds"

for mode_name,enabled in pairs(require "user.modes") do
    if type(enabled) == "boolean" and enabled then require(mode_name).setup() end
end

vim.cmd.colorscheme(color_schemes[4])
