require "user.packer-plugins"
require "user.cmp"
require "user.lsp"
require "user.set_modes"
require "user.treesitter"

require("nvim-tree").setup()
--require('lualine').setup()

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--map("n", ",<Space>", ":noh", { noremap = true })
--
vim.mapleader = " "
vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
vim.keymap.set("n","<Space>fm",vim.cmd.Ex)
vim.keymap.set("n","<ESC><ESC><ESC>",vim.cmd.noh)

do 
	local builtin = require("telescope.builtin")
	vim.keymap.set("n","<Space>g",builtin.live_grep)
	vim.keymap.set("n","<Space>f",builtin.find_files)
end

--vim.cmd "colorscheme nightfox"
--vim.cmd('colorscheme poimandres')
--vim.cmd('colorscheme gruvbox')
vim.cmd.colorscheme "catppuccin"
