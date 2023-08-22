local color_schemes = {"nightfox","poimandres","gruvbox","catppuccin"}

require "user.packer-plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keybinds"

for mode_name,enabled in pairs(require "user.set_modes") do
    if type(enabled) == "boolean" and enabled then require(mode_name).setup() end
end

vim.cmd.colorscheme(color_schemes[#color_schemes])
