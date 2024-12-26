require('treesj').setup({use_default_keymaps = false})

vim.keymap.set('n', '<Space>r{', ":TSJJoin<cr>", { desc = 'Document join' })
vim.keymap.set('n', '<Space>r}', ":TSJSplit<cr>", { desc = 'Document split' })
