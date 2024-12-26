local M = {}

function M.setup()
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
    vim.g.netrw_banner = 0
    vim.g.netrw_liststyle = 3
    vim.g.netrw_sftp_cmd = "scp"
    vim.g.netrw_http_cmd = "curl"
end

return M
