local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n","<Space>g",telescope_builtin.live_grep)
vim.keymap.set("n","<Space>f",telescope_builtin.find_files)

vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
vim.keymap.set("n","<Space>fm",vim.cmd.Ex)
vim.keymap.set("n","<ESC><ESC><ESC>",vim.cmd.noh)

