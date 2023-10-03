local keybinds = {}

local keys = {}
keys.space = "<Space>"
keys.leader = "<leader>"

keybinds.telescope = {
    live_grep = {key = keys.space.."lg"},
    find_files = {key = keys.space.."ff"},
}

keybinds.git = {
    git_window = {key = keys.space.."gw"},
}

keybinds.file_manager = {
    netrw = {key = keys.space.."fm"}
}

keybinds.nvim_tree = {
    toggle = {key = keys.space.."tt"}
}

keybinds.treesj = {
    toggle = {key = keys.leader.."m"},
    toggle_split = {key = keys.leader.."M"}
}

keybinds.my_commands = {
    buf_cap_word = {key = keys.space.."ll"}
}

keybinds.terminal = {
    toggle = {key = keys.space.."."}
}

return keybinds
