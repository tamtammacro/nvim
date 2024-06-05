local exports = {}
local options = require "options"

function exports.goto_config()
    vim.cmd.vsplit()

    if vim.fn.has "win32" then
        vim.cmd.e(vim.env.HOME.."\\AppData\\Local\\nvim")
    else
        vim.cmd.e("~/.config/nvim")
    end
end

return exports
