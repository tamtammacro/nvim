local success,telescope = pcall(require,"telescope")

if not success then return print "telescope is not installed" end

require("telescope.themes").get_dropdown {}

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "cache",
            "CMakeFiles",
            "out",
            "vs",
            "vscode",
            "class",
            "pdf",
            "dll",
        },
    }
})

xpcall(function()
    telescope.load_extension("ui-select")
    telescope.load_extension('harpoon')

    --telescope.load_extension("noice")
end,print)

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<Space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<Space>fs', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
vim.keymap.set('n', '<Space>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<Space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<M-8>', builtin.keymaps, { desc = 'Telescope keymaps' })
