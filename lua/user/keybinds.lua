local keybinds = {}

local keys = {}
keys.space = "<Space>"
keys.leader = "<leader>"

keybinds.telescope = {
    live_grep = {key = keys.space.."g"},
    find_files = {key = keys.space.."ff"},
}

keybinds.file_manager = {
    netrw = {key = keys.space.."fm",mode = "n"}
}

keybinds.nvim_tree = {
    toggle = {key = keys.space.."ffm"}
}

keybinds.treesj = {
    toggle = {key = keys.leader.."m"},
    toggle_split = {key = keys.leader.."M"}
}

keybinds.rose_commands = {
    buf_cap_word = {key = keys.space.."ll"}
}

local utils = require "user.util_functions"

local function mrn(mode)
    return mode or "n"
end

local function set_keymap(mode,key,callback)
    vim.keymap.set(mode,key,callback)
end

do
    local telescope_builtin = require("telescope.builtin")
    set_keymap(mrn(keybinds.telescope.live_grep.mode),keybinds.telescope.live_grep.key,telescope_builtin.live_grep)
    set_keymap(mrn(keybinds.telescope.find_files.mode),keybinds.telescope.find_files.key,telescope_builtin.find_files)

    set_keymap(mrn(keybinds.file_manager.netrw.mode),keybinds.file_manager.netrw.key,vim.cmd.Ex)
end

local options = require "user.options"
vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
set_keymap("n","<ESC><ESC><ESC>",vim.cmd.noh)

if options["nvim-tree"].enabled then
    vim.keymap.set(mrn(keybinds.nvim_tree.toggle.mode),keybinds.nvim_tree.toggle.key,vim.cmd.NvimTreeToggle)
end

if options["treesj"] then
    set_keymap(mrn(keybinds.treesj.toggle.mode), keybinds.treesj.toggle.key, require('treesj').toggle)
    set_keymap(mrn(keybinds.treesj.toggle_split.mode),keybinds.treesj.toggle_split.key, function()
        require('treesj').toggle({ split = { recursive = true } })
    end)
end

set_keymap(mrn(keybinds.rose_commands.buf_cap_word.mode),keybinds.rose_commands.buf_cap_word.key,utils.buf_cap_word)

return keybinds
