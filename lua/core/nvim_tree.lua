local options = require "user.options"
local nvim_tree_opts = options["nvim-tree"]

if not nvim_tree_opts.enabled then return end

-- vim.g.nvim_tree_show_icons = {
--     folders = false,
--     files = false,
--     git = false,
--     folder_arrows = false,
-- }

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 0,
  folder_arrows = 0,
}
vim.defer_fn(function()
    require("nvim-tree").setup{
        view = {
            width = nvim_tree_opts.width,
            adaptive_size = nvim_tree_opts.adaptive_size,
            side = nvim_tree_opts.side
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
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
end,50)

