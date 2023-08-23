local color_schemes = {"nightfox","poimandres","gruvbox","catppuccin"}

require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.keybinds"

for opt_name,state in pairs(require "user.options") do
    if type(state) == "table" and state.enabled then
        require(opt_name).setup()
    elseif type(state) == "boolean" and state then
        require(opt_name).setup()
    end
end

require "user.modes"

vim.cmd.colorscheme(color_schemes[4])
