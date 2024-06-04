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

    highlight_indentation = {
        enabled = true,
        module = "ibl",
    },

    colorizer = {
        enabled = true,
        module = "colorizer",
    },

    auto_tag = {
        enabled = true,
        module = "auto_tag"
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
        style = "",
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

    conform = {
        enabled = true,
        module = "conform"
    },

    nvim_tree = {
        enabled = true,
        on_startup = true,
        side = "left",
        path = "nvim_tree",
        width = 30,
        adaptive_size = true
    },

    discord = {
        enabled = false,
        module = "discord_presence",
        style = "neocord"
    },

    godot = {
        enabled = false,
        module = "godot"
    },

    theme = {
        enabled = true,
        name = "rose-pine",
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
