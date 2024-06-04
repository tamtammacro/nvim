local keymaps = {}
local options = require "options"

local SPACE = "<Space>"
local LEADER = "<leader>"
local ENTER = "<CR>"

local ALT = function(key)
    return "<M-"..key..">"
end

local CONTROL = function(key)
    return "<C-"..key..">"
end

local C = "c."
local L = "l."
local E = "e."

keymaps.VIM_COMMAND_PREFIX = C
keymaps.LUA_COMMAND_PREFIX = L
keymaps.EDITOR_COMMAND_PREFIX = E

keymaps.lsp_trouble = {
    toggle = {key = LEADER.."xx",cmd=C.."TroubleToggle"},
    workspace_diagnostics = {key = LEADER.."xw",cmd="open"},
    document_diagnostics = {key = LEADER.."xd",cmd="open"},
    quick_fix = {key = LEADER.."xq",cmd=C.."Trouble quick_fix"},
    locklist = {key = LEADER.."xl",cmd="open"},
    lsp_references = {key = LEADER.."gR",cmd="open"},
}

keymaps.goto = {
    goto_preview = { key = "gp", cmd="goto_preview_definition",desc = "goto signature preview" },
}

keymaps.telescope = {
    find_files = { key = SPACE.."ff" , desc = "find files"},
    live_grep = { key = SPACE.."fg", desc = "live grep" },
    lsp_document_symbols = {key = SPACE.."fs", desc = "find lsp symbols"},
    oldfiles = {key = SPACE.."fo", desc = "find old files"},
    grep_string = {key = SPACE.."fw"},
    keymaps = {key = SPACE.."km", desc = "show key maps"}
}

keymaps.lsp = {
    signature = {key = nil,desc="lsp help signature",mode="i",cmd = L.."vim.lsp.buf.signature_help()"},
    code_action = {key=SPACE..ENTER,cmd = L.."vim.lsp.buf.code_action()",desc = "code action"},

    goto_defination = {key = "gd",desc="goto symbol defination",cmd = L.."vim.lsp.buf.definition()"},
    goto_defination_2 = {key = CONTROL("b"),desc="goto symbol defination, Intellij idea",cmd = L.."vim.lsp.buf.definition()"},

    goto_next = {key = "[d",cmd = L.."vim.diagnostic.goto_next()"},
    goto_prev = {key = "]d",cmd = L.."vim.diagnostic.goto_prev()"},
    references = {key=SPACE.."kr",cmd = L.."vim.lsp.buf.references()"},
    rename = {key = SPACE.."rr",cmd = L.."vim.lsp.buf.rename()"}, -- f2 key does the same action -- 
    open_float = {key = LEADER.."vd",cmd=L.."vim.diagnostic.open_float()"},
    workspace_symbol = {key = LEADER.."kf",cmd=L.."vim.lsp.buf.workspace_symbol()"},
    hover = {key = SPACE.."q",cmd=L.."vim.lsp.buf.hover()",desc = "symbol information (hover)"},
}

keymaps.conform = {
    format = { key = SPACE.."fd", cmd=L.."vim.lsp.buf.format()", desc="format document" },
}

keymaps.git = {
    git_window = { key = SPACE.."gw", cmd=C.."Git", desc="git window" },
}

keymaps.symbols_outline = {
    toggle = {key = ALT("7"),cmd=C.."SymbolsOutline",desc="symbols outline"}
}

keymaps.file_explorer = {
    toggle = {key = SPACE.."fm",cmd=options.file_explorer.path == "netrw" and C.."Ex" or C.."Oil",desc = "file manager"}
}

keymaps.treesj = {
    toggle = {key = LEADER.."m",cmd=C.."TSJToggle",desc="treesj"}
}

keymaps.nvim_tree = {
    toggle = {key = ALT("1"),cmd=C.."NvimTreeToggle",desc = "toggle nvim-tree"}
}

keymaps.terminal = {
    toggle = {key = nil,cmd=C.."ToggleTerm",desc="open terminal"}
}

keymaps.split_controls = {
    set_size_left = {key = ALT(","),cmd = E.."<c-w>5<",desc = "appends split view size to the left"},
    set_size_right = {key = ALT("."),cmd = E.."<c-w>5>",desc = "appends split view size to the right"},
    set_size_up = {key = ALT("t"),cmd = E.."<C-W>+",desc = "appends split view size upwards"},
    set_size_down = {key = ALT("s"),cmd = E.."<C-W>-",desc = "appends split view size downwards"}
}

return keymaps
