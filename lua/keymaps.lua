local keymaps = {}
local options = require "options"

local SPACE_S = "<Space>"
local LEADER_S = "<leader>"
local ENTER_S = "<CR>"

local ENTER = "cr"
local LEFT_ARROW = "left"
local RIGHT_ARROW = "right"
local UP_ARROW = "up"
local DOWN_ARROW = "down"

local ALT = function(key)
    return "<M-"..key..">"
end

local ALT_SHIFT = function(key)
    return "<M-S-"..key..">"
end

local CONTROL = function(key)
    return "<C-"..key..">"
end

local CONTROL_SHIFT = function(key)
    return "<C-S-"..key..">"
end

local C = "c."
local L = "l."
local E = "e."

keymaps.VIM_COMMAND_PREFIX = C
keymaps.LUA_COMMAND_PREFIX = L
keymaps.EDITOR_COMMAND_PREFIX = E

keymaps.lsp_trouble = {
    toggle = {key = nil},
    workspace_diagnostics = {key = nil},
    document_diagnostics = {key = nil},
    quick_fix = {key = nil},
    locklist = {key = nil},
    lsp_references = {key = nil},
}

keymaps.goto = {
    preview = { key = "gp", cmd="goto_preview_definition",desc = "goto signature preview" },
}

keymaps.telescope = {
    find_files = { key = SPACE_S.."ff" , desc = "find files"},
    live_grep = { key = SPACE_S.."fg", desc = "live grep" },
    lsp_document_symbols = {key = SPACE_S.."fs", desc = "find lsp symbols"},
    oldfiles = {key = SPACE_S.."fo", desc = "find old files"},
    grep_string = {key = SPACE_S.."fw"},
    keymaps = {key = SPACE_S.."km", desc = "show key maps"}
}

keymaps.lsp = {
    signature = {key = nil,desc="lsp help signature",mode="i",cmd = L.."vim.lsp.buf.signature_help()"},
    code_action = {key=SPACE_S..ENTER_S,cmd = L.."vim.lsp.buf.code_action()",desc = "code action"},
    code_action_2 = {key=ALT(ENTER),cmd = L.."vim.lsp.buf.code_action()",desc = "code action"},

    goto_defination = {key = "gd",desc="goto symbol defination",cmd = L.."vim.lsp.buf.definition()"},
    goto_defination_2 = {key = CONTROL("b"),desc="goto symbol defination, Intellij idea",cmd = L.."vim.lsp.buf.definition()"},

    goto_next = {key = SPACE_S.."d.",cmd = L.."vim.diagnostic.goto_next()"},
    goto_prev = {key = SPACE_S.."d,",cmd = L.."vim.diagnostic.goto_prev()"},
    references = {key=SPACE_S.."kr",cmd = L.."vim.lsp.buf.references()"},
    rename = {key = SPACE_S.."rr",cmd = L.."vim.lsp.buf.rename()"}, -- f2 key does the same action -- 
    open_float = {key = LEADER_S.."vd",cmd=L.."vim.diagnostic.open_float()"},
    workspace_symbol = {key = LEADER_S.."kf",cmd=L.."vim.lsp.buf.workspace_symbol()"},
    hover = {key = SPACE_S.."kq",cmd=L.."vim.lsp.buf.hover()",desc = "symbol information (hover)"},
}

keymaps.undotree = {
    toggle = {key = ALT("4"),cmd=C.."UndotreeToggle",desc="undo tree toggle"}
}

keymaps.conform = {
    format = { key = SPACE_S.."kf", cmd=L.."vim.lsp.buf.format()", desc="format document" },
}

keymaps.git = {
    git_window = { key = nil, cmd=C.."Git", desc="git window" },
    diff_view_open = { key = ALT("g"), cmd=C.."DiffviewOpen", desc="git diff view" },
}

keymaps.symbols_outline = {
    toggle = {key = ALT("7"),cmd=C.."SymbolsOutline",desc="symbols outline"}
}

keymaps.file_explorer = {
    toggle = {key = SPACE_S.."fm",cmd=options.file_explorer.path == "netrw" and C.."Ex" or C.."Oil",desc = "file manager"}
}

keymaps.treesj = {
    toggle = {
        key = SPACE_S.."f",
        cmd=C.."TSJToggle",
        desc="treesj",
    }
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
    set_size_down = {key = ALT("s"),cmd = E.."<C-W>-",desc = "appends split view size downwards"},

    switch_split_left = {key = CONTROL("j"),cmd = E.."<c-w><c-h>",desc = "set split view to the left"},
    switch_split_right = {key = CONTROL("k"),cmd = E.."<c-w><c-l>",desc = "set split view to the right"},
}

keymaps.tabs = {
    go_left = {key = ALT(LEFT_ARROW),cmd = C.."BufferPrevious"},
    go_right = {key = ALT(RIGHT_ARROW),cmd = C.."BufferNext"},

    move_left = {key = ALT(DOWN_ARROW),cmd = C.."BufferMovePrevious"},
    move_right = {key = ALT(UP_ARROW),cmd = C.."BufferMoveNext"}
}

return keymaps
