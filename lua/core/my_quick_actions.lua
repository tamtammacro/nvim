local exports = {}
local io_funcs = require "helper.io_func"

function exports.goto_config()
    vim.cmd.vsplit()
    vim.cmd.e(io_funcs.get_config_loc())
end

return exports
