return {
    lazy_plugins = false, -- package manager --

    ["nvim-tree"] = {
        enabled = true,
        on_startup = true
    },

    lualine = true,
    treesj = true,

    lsp_trouble = {
        enabled = true,
        on_startup = false
    },

    terminal = true,
    tabs = true
}
