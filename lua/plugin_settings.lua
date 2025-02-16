local defaults = {
    telescope = {
        enabled = true,
        modules = {builtin = "telescope.builtin",config = "plugin_conf.telescope"}
    },

    git = {
        enabled = true,
        modules = {gitsigns = "gitsigns",gitcore = "plugin_conf.git"},
    },

    tmux_nav = {
        enabled = true,
        module = "plugin_conf.tmux_nav"
    },

    which_key = {
        enabled = true,
        module = "plugin_conf.which_key"
    },

    harpoon = {
        enabled = true,
        module = "plugin_conf.harpoon"
    },

    numb = {
        enabled = true,
        module = "plugin_conf.numb"
    },

    undotree = {
        enabled = true,
    },

    lualine = {
        enabled = false,
        module = "plugin_conf.status_line"
    },

    refactoring = {
        enabled = true,
        module = "refactoring",
    },

    webdev_icons = {
        enabled = true,
        module = "plugin_conf.webdev_icons"
    },

    treesj = {
        enabled = true,
        modules = {_ = "plugin_conf.treesj"}
    },

    nvim_tree = {
        enabled = true,
        module = "plugin_conf.nvim_tree",
    },

    discord = {
        enabled = false,
        module = "plugin_conf.discord_presence",
    },

    godot = {
        enabled = true,
        module = "plugin_conf.godot"
    },

    file_explorer = {
        enabled = true,
        module = "plugin_conf.file_explorer"
    },

    lsp = {
        enabled = true,
        modules = {lsp = "plugin_conf.lsp",cmp = "plugin_conf.cmp"}
    },

    dap = {
        enabled = true,
        module = "plugin_conf.dap"
    }
}

return defaults
