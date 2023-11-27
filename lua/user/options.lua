local DEFAULT_DEFER_TIME = 1

local options = {
    want_default_keybinds = true,
    want_telescope = true,
    want_leap = true,
    deferring_enabled = true,

    plugins = {
        enabled = true,
    },

    git = {
        enabled = true,
        paths = {"gitsigns"}
    },

    noice = {
        enabled = false,
        path = "noice",
        defer = DEFAULT_DEFER_TIME,
    },

    refractoring = {
        enabled = true,
        path = "refractoring",
    },

    highlighted_indentation = {
        enabled = true,
        path = "ibl",
        defer = .25
    },

    highlighted_colors = {
        enabled = true,
        path = "colorizer",
        defer = DEFAULT_DEFER_TIME,
    },

    symbols_outline = {
        enabled = true,
        path = "symbols-outline",
        defer = .5
    },

    illuminate = {
        enabled = true,
        path = "illuminate",
        defer = .5,
    },

    lua_line = {
        enabled = true,
        path = "lualine",
        which = "evil",
    },

    tree_sitter = {
        enabled = true,
        path = "treesitter",
        defer = .25
    },

    treesj = {
        enabled = true,
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
        defer = DEFAULT_DEFER_TIME 
    },

    my_user_commands_info = {
        prefix = "my",
        enabled = false
    },

    ["nvim-tree"] = {
        enabled = true,
        on_startup = false,
        path = "nvim-tree",
        defer = DEFAULT_DEFER_TIME
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "tokyonight-night",
        arg = "darker"
    },

    lsp_trouble = {
        enabled = true,
        path = "trouble",
        defer = DEFER_DEFAULT
    },

    terminal = {
        enabled = true,
        path = "term",
        defer = DEFAULT_DEFER_TIME
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
        defer = DEFFAULT_DEFER_TIME
    }
}

return options
