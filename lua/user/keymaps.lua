local keymaps = {}

local keys = {}
keys.space = "<Space>"
keys.leader = "<leader>"

keys.control = "C"
keys.alt = "cmd"

function keys.format(what,k)
    local formatted_str = ("<%s-"):format(what)

    for index = 1,#k do
        formatted_str = formatted_str..k:sub(index,index)

        if index ~= #k then
            formatted_str = formatted_str.."-"
        end
    end

    return formatted_str..">"
end

keymaps.lsp_trouble = {
    toggle = {key = keys.leader.."xx"},
    workspace_diagnostics = {key = keys.leader.."xw"},
    document_diagnostics = {key = keys.leader.."xd"},
    quick_fix = {key = keys.leader.."xq"},
    locklist = {key = keys.leader.."xl"},
    lsp_reference = {key = keys.leader.."gR"},
}

keymaps.goto = {
    goto_preview = {key = "gp"}
}

keymaps.telescope = {
    live_grep = {key = keys.space.."lg"},
    find_files = {key = keys.space.."ff"},
}

keymaps.git = {
    git_window = {key = keys.space.."gw"},
}

keymaps.file_explorer = {
    toggle = {key = keys.space.."fm"}
}

keymaps.nvim_tree = {
    toggle = {key = keys.leader.."e"}
}

keymaps.treesj = {
    toggle = {key = keys.leader.."m"},
    toggle_split = {key = keys.leader.."M"}
}

keymaps.my_commands = {
    buf_cap_word = {key = keys.leader.."ll"}
}

keymaps.terminal = {
    toggle = {key = keys.space.."."}
}

return keymaps
