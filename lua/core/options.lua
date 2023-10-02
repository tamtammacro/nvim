local state = {initilized = false}

local options = {
    want_lazy_plugins = false, -- package manager --
    want_godot = true,
    want_my_user_commands = true,
    want_default_keybinds = true,
    want_tree_sitter = true,

    my_user_commands_info = {
        prefix = "my"
    },
    ["nvim-tree"] = {
        enabled = false,
        on_startup = false
    },

    want_lualine = false,
    want_treesj = true,
    background = {
        is_transparent = false, 
    },
    color_scheme = {
        allow_custom = true,
        name = "gruvbox",
        arg1 = "darker"
    },

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
    },

    lsp = {
        enabled = true
    }
}

function options:use_plugins()
    if self.want_lazy_plugins then require "user.lazyplugins" else require "user.plugins" end

    require "user.modes"

    if self.lsp.enabled then
        require "core.cmp"
        require "core.lsp"
    end

    if self.want_my_user_commands then
        require "user.usercommands"
    end

    if self.want_tree_sitter then
        require "core.treesitter"
    end

    if self.want_default_keybinds then
        require "user.keybinds"
    end
end

function options:use_visuals()
    if self.color_scheme.allow_custom then
        vim.cmd.colorscheme(self.color_scheme.name)
        if (self.color_scheme.name == "material") then vim.g.material_style = self.color_scheme.arg1 end
    end

    if self.background.is_transparent then
        vim.cmd["highlight"]("Normal guibg=none")
    end
end

return options
