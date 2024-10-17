local M = {}
local preferences = require("preferences")

function M.setup()
    preferences.editor.file_explorer.name = preferences.conf.template == "minimal" and "netrw" 
    or 
    preferences.editor.file_explorer.name

    if preferences.editor.file_explorer.name ~= "netrw" then
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrw = 1
    end

    vim.g.netrw_banner = 0
    vim.g.netrw_liststyle = 3
    vim.g.netrw_sftp_cmd = "scp"
    vim.g.netrw_http_cmd = "curl"
end

return M
