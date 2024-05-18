local DEFAULT_DEFER_TIME = 0

local options = {
    plugins = {
        deferring_enabled = true,
        enabled = true
    },

    telescope = {
        enabled = true,
        path = "telescope"
    },

    leap_ = {
        enabled = false,
        path = "leap"
    },

    git = {
        enabled = true,
        paths = {"gitsigns"}
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
        enabled = false,
        path = "lualine",
        which = "evil",
    },

    tree_sitter = {
        enabled = true,
        path = "treesitter",
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
        path = "nvim-tree",
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "gruvbox",
        style = "darker"
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
        enabled = false,
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
