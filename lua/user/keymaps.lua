local keymaps = {}
local options = require "user.options"

local SPACE = "<Space>"
local LEADER = "<leader>"
local CONTROL = "C-"

keymaps.lsp_trouble = {
    toggle = {key = LEADER.."xx",cmd="v.TroubleToggle"},
    workspace_diagnostics = {key = LEADER.."xw",cmd="open"},
    document_diagnostics = {key = LEADER.."xd",cmd="open"},
    quick_fix = {key = LEADER.."xq",cmd="v.Trouble quick_fix"},
    locklist = {key = LEADER.."xl",cmd="open"},
    lsp_references = {key = LEADER.."gR",cmd="open"},
}

keymaps.goto = {
    goto_preview = { key = "gp", cmd="goto_preview_definition",desc = "goto preview" },
}

keymaps.telescope = {
    find_files = { key = SPACE.."ff" , desc = "find files"},
    live_grep = { key = SPACE.."fg", desc = "live grep" },
    lsp_document_symbols = {key = SPACE.."fs", desc = "find lsp symbols"},
    oldfiles = {key = SPACE.."fo", desc = "find old files"},
    grep_string = {key = SPACE.."fw"},
    keymaps = {key = SPACE.."km", desc = "show key maps"}
}

keymaps.git = {
    git_window = { key = SPACE.."gw", cmd="v.Git", desc="git window" },
}

keymaps.symbols_outline = {
    toggle = {key = LEADER.."s",cmd="v.SymbolsOutline",desc="symbols outline"}
}

keymaps.file_explorer = {
    toggle = {key = SPACE.."fm",cmd=options.file_explorer.path == "netrw" and "v.Ex" or "v.Oil",desc = "file manager"}
}

keymaps.treesj = {
    toggle = {key = LEADER.."m",cmd="v.TSJToggle",desc="treesj"}
}

keymaps["nvim-tree"] = {
    toggle = {key = SPACE.."1",cmd="v.NvimTreeToggle",desc = "nvim-tree"}
}

keymaps.terminal = {
    toggle = {key = SPACE..".",cmd="v.ToggleTerm",desc="terminal"}
}

local set = vim.keymap.set

set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

return keymaps
