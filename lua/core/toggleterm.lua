local exports = {}
local success, toggleterm = pcall(require, "toggleterm")

if not success then return print "toggleterm is not installed" end

local Terminal = require "toggleterm.terminal".Terminal

function exports.toggle()
    local floating_terminal = Terminal:new({direction = "float"})
    floating_terminal:toggle()
end

toggleterm.setup {
    shade_terminals = true,
    shade_filetypes = {},
    size = 13,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal"
}

return exports
