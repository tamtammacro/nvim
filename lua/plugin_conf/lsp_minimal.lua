local lsp_data = {
    {cmd = {"lua-language-server","--stdio"}, pattern = "lua"},
    {cmd = {"clangd"}, pattern = {"c", "cpp", "objc"}}
}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function is_language_server_present(language_server_name)
    local handle = io.popen(vim.loop.os_uname().sysname == 
    "Windows_NT" and "where " or "which " .. language_server_name)

    local result = handle:read("*a")

    handle:close()

    return result ~= ""
end 

for _, lsp in ipairs(lsp_data) do
    if is_language_server_present(lsp.cmd[1]) then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lsp.pattern,
            callback = function()
                local client_id = vim.lsp.start_client({
                    cmd = lsp.cmd,
                    root_dir = vim.fn.getcwd(),
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                    end,
                  })

                  vim.lsp.buf_attach_client(0, client_id)
              end,
        })
    end
end

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
})

