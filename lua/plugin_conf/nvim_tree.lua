local success, nvim_tree = pcall(require, "nvim-tree")

if not success then return print "nvim-tree is not installed" end

vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 0,
    files = 0,
    folder_arrows = 0,
}

nvim_tree.setup {
    auto_reload_on_write = true,
    view = {
        width = 30,
        adaptive_size = true,
        side = "left",
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
        dotfiles = false,
        git_ignored = true,
    },
    update_focused_file = {
        enable = true,
    },
}

if false then
    local main_window = vim.api.nvim_get_current_win()
    vim.cmd.NvimTreeOpen()
    vim.api.nvim_set_current_win(main_window)
end

vim.keymap.set('n', '<M-1>',":NvimTreeToggle<cr>", { desc = 'nvim tree toggle' })
