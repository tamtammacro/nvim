local defaults = {}

local JSON = require("helper.json")

local table_e = require "helper.table_e"
local file_data = require "helper.file_data"

local preferences = require "preferences"

if not preferences then return print "failed to fetch preferences in keymaps.lua" end

local file = require "helper.file"

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

function isDiffviewOpen()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("^diffview://") then return true end
    end
end

function isGitRepo()
  local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
  local result = handle:read('*a')
  handle:close()
  return result:match('true') ~= nil
end

function toggleGitDiffview()
    if isDiffviewOpen() then
        vim.cmd.DiffviewClose() 
    elseif not isDiffviewOpen() and isGitRepo() then
        vim.cmd.DiffviewOpen()
    end
end

local C = ":"
local L = "lua ->"
local E = "v."

local cmd_types = {}

defaults.goto = {
    preview = { key = "gp", cmd="goto_preview_definition", desc = "goto signature preview" },
}

-- defaults.telescope = {
--     find_files = { key = SPACE_S.."ff" , desc = "find files"},
--     live_grep = { key = SPACE_S.."fg", desc = "file with live grep" },
--     lsp_document_symbols = {key = SPACE_S.."fs", desc = "find lsp symbols"},
--     oldfiles = {key = SPACE_S.."fo", desc = "find old files"},
--     grep_string = {key = SPACE_S.."fw"},
--     buffers = {key = SPACE_S.."fb",desc = "find file buffers"},
--     keymaps = {key = ALT("8"),desc = "show key maps"},
-- }

defaults.lsp_ = {
    signature = {key = SPACE_S.."fk",desc="lsp help signature",cmd = L.."vim.lsp.buf.signature_help()"},

    code_action = {key=ALT(ENTER),cmd = L.."vim.lsp.buf.code_action()",desc = "code action"},

    goto_defination = {key = "gd",desc="goto symbol defination",cmd = L.."vim.lsp.buf.definition()"},
    goto_defination_intellij_idea = {key = CONTROL("b"),desc="goto symbol defination, Intellij idea",cmd = L.."vim.lsp.buf.definition()"},

    goto_next = {key = SPACE_S.."d.",cmd = L.."vim.diagnostic.goto_next()"},
    goto_prev = {key = SPACE_S.."d,",cmd = L.."vim.diagnostic.goto_prev()"},
    rename = {key = SPACE_S.."rr",cmd = L.."vim.lsp.buf.rename()",desc="rename"}, -- f2 key does the same -- 
    open_float = {key = LEADER_S.."vd",cmd=L.."vim.diagnostic.open_float()"},
    workspace_symbol = {key = nil,cmd=L.."vim.lsp.buf.workspace_symbol()"},
    hover = {key = SPACE_S.."fq",cmd=L.."vim.lsp.buf.hover()",desc = "find symbol information (hover)"},
    references = {key=SPACE_S.."fr",cmd = L.."vim.lsp.buf.references()",desc="find references"},
}

defaults.dap = {
    breakpoint = {key = SPACE_S.."db",cmd = C.."DapToggleBreakpoint",desc="debug toggle breakpoint"},
    continue = {key = SPACE_S.."dc",cmd = C.."DapContinue",desc="debug continue"},
}

defaults.undotree = {
    toggle = {key = ALT("5"),cmd=C.."UndotreeToggle",desc="undo tree toggle"}
}

defaults.conform = {
    format = { key = SPACE_S.."kf", cmd=L.."vim.lsp.buf.format()", desc="document format" },
}

-- defaults.git = {
--     git_window = { key = nil, cmd=C.."Git", desc="git window" },
--     diff_view_toggle = { key = ALT("g"), cmd=toggleGitDiffview,desc="git toggle diffview" },
-- }

defaults.symbols_outline = {
    toggle = {key = ALT("7"),cmd=C.."SymbolsOutline",desc="symbols outline"}
}

-- defaults.file_explorer = {
--     toggle = {key = SPACE_S.."fm",cmd=preferences.editor.file_explorer.name == "netrw" and C.."Ex" or C.."Oil",desc = "file manager"}
-- }

-- defaults.treesj = {
--     join = { key = SPACE_S.."k{", cmd=C.."TSJJoin", desc="document join" },
--     split = { key = SPACE_S.."k}", cmd=C.."TSJSplit", desc="document split" }
-- }

defaults.my_quick_actions = {
    config = { key = LEADER_S..".", cmd="goto_config" },
    show_notifications = {key = LEADER_S.."n",cmd=C.."Notifications"}
}

-- defaults.nvim_tree = {
--     toggle = { key = ALT"1", cmd=C.."NvimTreeToggle", desc = "nvim-tree toggle" }
-- }

defaults.terminal = {
    toggle = {key = ALT"3",cmd="toggle",desc="terminal open"}
}

defaults.split_controls = {
    set_size_left = {key = ALT(","),cmd = E.."<c-w>5<",desc = "splitview append size to the left"},
    set_size_right = {key = ALT("."),cmd = E.."<c-w>5>",desc = "splitview append size to the right"},
    set_size_up = {key = ALT(";"),cmd = E.."<C-W>+",desc = "splitview append size upwards"},
    set_size_down = {key = ALT("'"),cmd = E.."<C-W>-",desc = "splitview append size downwards"},

    switch_split_left = {key = CONTROL("h"),cmd = E.."<c-w><c-h>",desc = "splitview set to the left"},
    switch_split_right = {key = CONTROL("l"),cmd = E.."<c-w><c-l>",desc = "splitview set to the right"},

    switch_split_up = {key = CONTROL("k"),cmd = E.."<c-w><c-k>",desc = "splitview go to top one"},
    switch_split_down = {key = CONTROL("j"),cmd = E.."<c-w><c-j>",desc = "splitview go to bottom one"},
}

defaults.tabs = {
    go_left = {key = ALT(LEFT_ARROW),cmd = C.."BufferPrevious",desc="tab previous"},
    go_right = {key = ALT(RIGHT_ARROW),cmd = C.."BufferNext",desc = "tab next"},

    move_left = {key = ALT(DOWN_ARROW),cmd = C.."BufferMovePrevious",desc="tab move previous"},
    move_right = {key = ALT(UP_ARROW),cmd = C.."BufferMoveNext",desc="tab move next"},
    close = {key = ALT("x"),cmd = C.."BufferClose",desc="tab close"}
}

local metadata = nil
local keymaps = nil

if preferences.conf.save_config then
    metadata = file_data.create({file_name = "keymaps.json"})

    if not metadata then return error "Could not create metadata for keymaps" end

    local file_content = file.read_all_file(metadata.path)
    keymaps = not file_content and defaults or JSON.decode(file_content)
else
    keymaps = defaults
end

-- keymaps.file_explorer.toggle = {key = SPACE_S.."fm",cmd=preferences.editor.file_explorer.name == "netrw" and C.."Ex" or C.."Oil",desc = "file manager"}

setmetatable(keymaps,{__index = function(self,key)
	if key == "__metadata__" then
		return metadata or {}
    elseif key == "__cmd_types__" then
        return cmd_types
	end

    return rawget(self,key)
end})

if preferences.conf.validate_config then
    coroutine.resume(coroutine.create(function()
        table_e.validate_config_table(defaults,keymaps,{},{"desc"})
    end))
end

cmd_types.VCP = C
cmd_types.LCP = L
cmd_types.ECP = E

return keymaps
