local success
local lspconfig

success,lspconfig = pcall(require,"lspconfig")
if not success then return print "lspconfig is not installed" end

local keymap_loader = require("core.load_keymaps")
local servers = {"pyright","tsserver","rust_analyzer", "cssls","gopls"}

local function on_attach(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  keymap_loader.load_keymaps("lsp",opts)
end

lspconfig.clangd.setup {
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}

for _,server_name in ipairs(servers) do
    require('lspconfig')[server_name].setup { on_attach = on_attach }
end

local lsp
success,lsp = pcall(require,"lsp-zero")

if not success then return print "lsp zero is not installed" end

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
})

lsp.nvim_workspace()

local cmp

success,cmp = pcall(require,'cmp')

if not success then return print "cmp is not installed" end

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(on_attach)
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
