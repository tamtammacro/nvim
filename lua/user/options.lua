return {
    lazy_plugins = false, -- package manager --
    godot = true,
    rose_user_commands = true,

    rose_user_commands_info = {
        prefix = "rose"
    },

    ["nvim-tree"] = {
        enabled = false,
        on_startup = false
    },

    lualine = true,
    treesj = true,
    no_background = false,

    support_images = {
        enabled = true,
        path = "hologram"
    },

    lsp_trouble = {
        enabled = true,
        on_startup = false,
        path = "trouble"
    },

    terminal = {
        enabled = true,
        path = "toggle_term"
    },

    tabs = {
        enabled = true,
        path = "barbar"
    }
}
