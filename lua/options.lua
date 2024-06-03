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

    split_controls = {
        enabled = true
    },

    noice = {
        enabled = false,
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

    status_line = {
        enabled = true,
        module = "status_line",
        style = "evil",
        name = "lualine"
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
        show_on_status_line = false,
        enabled = true,
        module = "tabnine",
        debounce_ms = 500,
    },

    nvim_tree = {
        enabled = true,
        on_startup = false,
        side = "left",
        path = "nvim_tree",
        width = 20,
        adaptive_size = true
    },

    discord = {
        enabled = false,
        module = "discord_presence",
        style = "neocord"
    },

    theme = {
        enabled = true,
        name = "tokyonight-night",
        transparent = false,
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
        enabled = false,
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
