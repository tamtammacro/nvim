local options = {
    plugins = {
        enabled = true,
        deferring_enabled = false
    },

    telescope = {
        enabled = true,
        modules = {"telescope.builtin","telescope_config"}
    },

    git = {
        enabled = true,
        modules = {"gitsigns"}
    },

    goto = {
        enabled = true,
        module = "goto-preview"
    },

    noice = {
        enabled = true,
        module = "noice",
    },

    refractoring = {
        enabled = true,
        module = "refractoring",
    },

    highlighted_indentation = {
        enabled = true,
        module = "ibl",
    },

    highlighted_colors = {
        enabled = true,
        module = "colorizer",
    },

    symbols_outline = {
        enabled = true,
        module = "symbols-outline",
    },

    illuminate = {
        enabled = true,
        module = "illuminate",
    },

    lua_line = {
        enabled = false,
        module = "lualine",
    },

    tree_sitter = {
        enabled = true,
        module = "treesitter",
    },

    webdev_icons = {
        enabled = true,
        module = "webdev_icons"
    },

    treesj = {
        enabled = true,
    },

    startup_screen = {
       enabled = true,
       module = "alpha",
    },

    tabnine_info = {
        show_on_lualine = false,
        enabled = true,
        module = "tabnine",
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
        enabled = false,
        module = "trouble",
    },

    terminal = {
        enabled = true,
        module = "term",
    },

    tabs = {
        enabled = true,
        module = "barbar"
    },

    file_explorer = {
        enabled = true,
        module = "oil"
    },

    lsp = {
        enabled = true,
        modules = {"lsp","cmp"},
    }
}

return options
