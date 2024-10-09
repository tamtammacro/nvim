local cmd = {"lua-language-server", "--stdio"}

local function start_lsp()
  local client_id = vim.lsp.start_client({
    cmd = cmd,
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.buf_attach_client(0, client_id)
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local client_id = vim.lsp.start_client({
  cmd = cmd,
  root_dir = vim.fn.getcwd(),
  capabilities = capabilities,
  -- on_attach = function(client, bufnr)
  -- end,
})

local cmd = { "clangd" }

local function start_clangd_lsp()
  local client_id = vim.lsp.start_client({
    cmd = cmd,
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.buf_attach_client(0, client_id)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp", "objc"},
  callback = function()
    start_clangd_lsp()
  end,
})

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

