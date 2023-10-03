local keybinds = {}

local keys = {}
keys.space = "<Space>"
keys.leader = "<leader>"

keybinds.lsp_trouble = {
    --open = {key = keys.leader.."xx"},
    workspace_diagnostics = {key = keys.leader.."xw"},
    document_diagnostics = {key = keys.leader.."xd"},
    quick_fix = {key = keys.leader.."xq"},
    locklist = {key = keys.leader.."xl"},
    lsp_reference = {key = keys.leader.."gR"},
    toggle = {key = keys.leader.."xx"}
}

keybinds.goto = {
    goto_preview = {key = "gp"}
}

keybinds.telescope = {
    live_grep = {key = keys.space.."lg"},
    find_files = {key = keys.space.."ff"},
}

keybinds.git = {
    git_window = {key = keys.space.."gw"},
}

keybinds.file_explorer = {
    toggle = {key = keys.space.."fm"}
}

keybinds.nvim_tree = {
    toggle = {key = keys.leader.."e"}
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
