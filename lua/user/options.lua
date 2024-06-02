local options = {
    plugins = {
        enabled = true,
        deferring_enabled = false
    },

    telescope = {
        enabled = true,
        path = "telescope.builtin"
    },

    git = {
        enabled = true,
        paths = {"gitsigns"}
    },

    goto = {
        enabled = true,
        path = "goto-preview"
    },

    noice = {
        enabled = false,
        path = "noice",
    },

    refractoring = {
        enabled = true,
        path = "refractoring",
    },

    highlighted_indentation = {
        enabled = true,
        path = "ibl",
    },

    highlighted_colors = {
        enabled = true,
        path = "colorizer",
    },

    symbols_outline = {
        enabled = true,
        path = "symbols-outline",
    },

    illuminate = {
        enabled = true,
        path = "illuminate",
    },

    lua_line = {
        enabled = true,
        path = "lualine",
    },

    tree_sitter = {
        enabled = true,
        path = "treesitter",
    },

    webdev_icons = {
        enabled = true,
        path = "webdev_icons"
    },

    treesj = {
        enabled = false,
    },

    startup_screen = {
       enabled = true,
       path = "alpha",
    },

    tabnine_info = {
        show_on_lualine = false,
        enabled = true,
        path = "tabnine",
        debounce_ms = 500,
    },

    my_user_commands_info = {
        prefix = "my",
        enabled = false
    },

    ["nvim-tree"] = {
        enabled = true,
        on_startup = false,
        side = "left",
        path = "nvim_tree",
        width = 20,
        adaptive_size = true
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "gruvbox",
    },

    lsp_trouble = {
        enabled = true,
        path = "trouble",
    },

    terminal = {
        enabled = true,
        path = "term",
    },

    tabs = {
        enabled = true,
        path = "barbar"
    },

    file_explorer = {
        enabled = true,
        path = "oil"
    },

    lsp = {
        enabled = true,
        paths = {"lsp","cmp"},
    }
}

return options
