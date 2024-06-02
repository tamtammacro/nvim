local keymaps = {}
local options = require "user.options"

local SPACE = "<Space>"
local LEADER = "<leader>"

-- Curently broken, multi-argument function --
keymaps.lsp_trouble = {
    toggle = {key = LEADER.."xx"},
    workspace_diagnostics = {key = LEADER.."xw",cmd="open"},
    document_diagnostics = {key = LEADER.."xd",cmd="open"},
    quick_fix = {key = LEADER.."xq",cmd="open"},
    locklist = {key = LEADER.."xl",cmd="open"},
    lsp_references = {key = LEADER.."gR",cmd="open"},
}

keymaps.goto = {
    goto_preview = {key = "gp",cmd="goto_preview_definition"}
}

keymaps.telescope = {
    live_grep = {key = SPACE.."lg"},
    find_files = {key = SPACE.."ff"},
}

keymaps.git = {
    git_window = {key = SPACE.."gw",cmd="v.Git"},
}

keymaps.symbols_outline = {
    toggle = {key = LEADER.."s",cmd="v.SymbolsOutline"}
}

keymaps.file_explorer = {
    toggle = {key = SPACE.."fm",cmd=options.file_explorer.path == "netrw" and "v.Ex" or "v.Oil"}
}

keymaps["nvim-tree"] = {
    toggle = {key = LEADER.."e",cmd="v.NvimTreeToggle"}
}

keymaps.terminal = {
    toggle = {key = SPACE..".",cmd="v.ToggleTerm"}
}

return keymaps
