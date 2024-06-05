local options = require "plugin_settings"
local nvim_tree_opts = options["nvim_tree"]

local success, nvim_tree = pcall(require, "nvim-tree")

if not success then return print "nvim-tree is not installed" end

vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 0,
    files = 0,
    folder_arrows = 0,
}
vim.defer_fn(function()
    nvim_tree.setup {
    auto_reload_on_write = true,
        view = {
            width = nvim_tree_opts.width,
            adaptive_size = nvim_tree_opts.adaptive_size,
            side = nvim_tree_opts.side,
            centralize_selection = false,
            cursorline = true,
            debounce_delay = 15,
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
        },
        renderer = {
            add_trailing = false,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "all",
            highlight_modified = "none",
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            }, group_empty = true,
        },
        filters = {
            dotfiles = not options.nvim_tree.show_dotfiles,
            git_ignored = not options.nvim_tree.show_gitignore,
        },
        update_focused_file = {
            enable = true,
        },
    }

    if nvim_tree_opts.on_startup then
        local main_window = vim.api.nvim_get_current_win()
        vim.cmd.NvimTreeOpen()
        vim.api.nvim_set_current_win(main_window)
    end
end, 50)
