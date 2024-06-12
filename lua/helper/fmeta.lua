local M = {}

local io_funcs = require "helper.io_func"

local folder_name = "settings"
local folder_path = io_funcs.get_config_loc() .. (io_funcs.is_win32() and "\\" .. folder_name or "/" .. folder_name)

function M.create_fmd(file_name,d)
    local meta = {
        folder_name = folder_name,
        folder_path = folder_path,
        file_name = file_name,
        path = folder_path .. "/" .. file_name
    }

    if d then
        for key,value in pairs(d) do
            meta[key] = value
        end
    end

    return meta
end

return M
