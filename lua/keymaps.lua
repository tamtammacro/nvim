local defaults = {}
local fmeta = require "helper.fmeta"
local options = require "plugin_settings"

local io_funcs = require "helper.io_func"

local TOML = require "vendor.lua-toml.toml"

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

local keymaps

defaults.__settings__ = {
    CUSTOM_DESCRIPTION = false
}

defaults.__cmd_types__  = {}
defaults.__metadata__ = fmeta.create_fmd("keymaps.toml")

defaults.goto = {
    preview = { key = "gp", cmd="goto_preview_definition", desc = "goto signature preview" },
}

defaults.telescope = {
    find_files = { key = SPACE_S.."ff" , desc = "find files"},
    live_grep = { key = SPACE_S.."fg", desc = "file with live grep" },
    lsp_document_symbols = {key = SPACE_S.."fs", desc = "find lsp symbols"},
    oldfiles = {key = SPACE_S.."fo", desc = "find old files"},
    grep_string = {key = SPACE_S.."fw"},
    buffers = {key = SPACE_S.."fb",desc = "find file buffers"},
    keymaps = {key = ALT("8"),desc = "show key maps"},
}

defaults.lsp = {
    signature = {key = nil,desc="lsp help signature",mode="i",cmd = L.."vim.lsp.buf.signature_help()"},
    code_action = {key=ALT(ENTER),cmd = L.."vim.lsp.buf.code_action()",desc = "code action"},

    goto_defination = {key = "gd",desc="goto symbol defination",cmd = L.."vim.lsp.buf.definition()"},
    goto_defination_intellij_idea = {key = CONTROL("b"),desc="goto symbol defination, Intellij idea",cmd = L.."vim.lsp.buf.definition()"},

    goto_next = {key = SPACE_S.."d.",cmd = L.."vim.diagnostic.goto_next()"},
    goto_prev = {key = SPACE_S.."d,",cmd = L.."vim.diagnostic.goto_prev()"},
    rename = {key = SPACE_S.."rr",cmd = L.."vim.lsp.buf.rename()",desc="rename"}, -- f2 key does the same action -- 
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

defaults.git = {
    git_window = { key = nil, cmd=C.."Git", desc="git window" },
    diff_view_open = { key = ALT("g"), cmd=C.."DiffviewOpen", desc="git diffviewopen" },
}

defaults.symbols_outline = {
    toggle = {key = ALT("7"),cmd=C.."SymbolsOutline",desc="symbols outline"}
}

defaults.file_explorer = {
    toggle = {key = SPACE_S.."fm",cmd=options.file_explorer.path == "netrw" and C.."Ex" or C.."Oil",desc = "file manager"}
}

defaults.treesj = {
    join = { key = SPACE_S.."k{", cmd=C.."TSJJoin", desc="document join" },
    split = { key = SPACE_S.."k}", cmd=C.."TSJSplit", desc="document split" }
}

defaults.my_quick_actions = {
    config = { key = LEADER_S..".", cmd="goto_config" },
    show_notifications = {key = LEADER_S.."n",cmd=C.."Notifications"}
}

defaults.nvim_tree = {
    toggle = { key = ALT"1", cmd=C.."NvimTreeToggle", desc = "nvim-tree toggle" }
}

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

    open_split = {key = CONTROL("s"),cmd=C.."split",desc="splitview open vertically"},
    open_vsplit = {key = ALT("s"),cmd=C.."vsplit",desc="splitview open horizontally"}
}

defaults.tabs = {
    go_left = {key = ALT(LEFT_ARROW),cmd = C.."BufferPrevious",desc="tab previous"},
    go_right = {key = ALT(RIGHT_ARROW),cmd = C.."BufferNext",desc = "tab next"},

    move_left = {key = ALT(DOWN_ARROW),cmd = C.."BufferMovePrevious",desc="tab move previous"},
    move_right = {key = ALT(UP_ARROW),cmd = C.."BufferMoveNext",desc="tab move next"},
    close = {key = ALT("x"),cmd = C.."BufferClose",desc="tab close"}
}

local file_content = io_funcs.read_all_file(defaults.__metadata__.path)
keymaps = not file_content and defaults or TOML.parse(file_content,{strict = true})

if not keymaps then
    print "ERROR: Something went wrong in keymaps.lua"
    return defaults
end

setmetatable(keymaps,{__index = function(self,key)
	if key == "__metadata__" then
		return rawget(defaults,"__metadata__")
	end

	if key == "__cmd_types__" then
		return rawget(defaults,"__cmd_types__")
	end

    return rawget(self,key)
end})

coroutine.resume(coroutine.create(function()
    for keymap_name,data in pairs(defaults) do
        if keymap_name ~= "__metadata__" then
            if keymaps[keymap_name] == nil and defaults[keymap_name] then
                keymaps.__metadata__.out_of_date = true
                keymaps[keymap_name] = data
            end
        end
        if type(data) == "table" then
            for opt, default_value in pairs(data) do
                if keymaps[keymap_name][opt] == nil then
                    keymaps.__metadata__.out_of_date = true
                    keymaps[keymap_name][opt] = default_value
                end
            end
        end
    end

    for keymap_name, data in pairs(keymaps) do
        if keymap_name ~= "__metadata__" then
            if defaults[keymap_name] == nil then
                keymaps[keymap_name] = nil
                keymaps.__metadata__.out_of_date = true
            end
        end
        if type(data) == "table" then
            for opt,value in pairs(data) do
                if defaults[keymap_name][opt] == nil then
                    keymaps[keymap_name][opt] = nil
                    keymaps.__metadata__.out_of_date = true
                end
                if keymaps.__settings__.CUSTOM_DESCRIPTION == false and defaults[keymap_name][opt] and opt == "desc" then
                   if defaults[keymap_name][opt] ~= value then
                       keymaps[keymap_name][opt] = defaults[keymap_name][opt]
                       keymaps.__metadata__.out_of_date = true
                   end
                end
            end
        end
    end

    coroutine.yield()
end))

defaults.__cmd_types__.VIM_COMMAND_PREFIX = C
defaults.__cmd_types__.LUA_COMMAND_PREFIX = L
defaults.__cmd_types__.EDITOR_COMMAND_PREFIX = E

return keymaps
