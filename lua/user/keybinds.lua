do
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n","<Space>g",telescope_builtin.live_grep)
    vim.keymap.set("n","<Space>ff",telescope_builtin.find_files)

    vim.keymap.set("n","<Space>fm",vim.cmd.Ex)
end

local options = require "user.options"
vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
vim.keymap.set("n","<ESC><ESC><ESC>",vim.cmd.noh)

if options["nvim-tree"] then
    vim.keymap.set("n","<Space>ffm",vim.cmd.NvimTreeToggle)
end

if options["treesj"] then
    vim.keymap.set('n', '<leader>m', require('treesj').toggle)
    vim.keymap.set('n', '<leader>M', function()
        require('treesj').toggle({ split = { recursive = true } })
    end)
end
