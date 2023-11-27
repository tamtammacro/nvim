local options = require "user.options"

local function new_hash(...)
    local t = {}
    
    for _,element in ipairs({...}) do
        t[element] = true
    end

    return t
end


local function _is_element(t,e)
    local i = 1
    local v = t[i]

    while v ~= nil do
        if v == e then return true end
        i = i + 1
        v = t[i]
    end
end

local function contains(t,e)
    return t[e]
end

local DEBUG_MODE_ENABLED = false
local INDENTBLANKLINE_BACKGROUNDCOLOR = 0xFF0000
local DEBUG_QUERY_EXCEPTIONS = new_hash("background","color_scheme","path","paths","defer","which")
local INDENT_BLANK_LINE_LIST = {"IndentBlanklineContextChar","IndentBlanklineChar","IndentBlanklineSpaceChar","IndentBlanklineSpaceCharBlankline","IndentBlanklineContextSpaceChar","IndentBlanklineContextStart"}
local FALLBACK_FUNC = {alpha = "Alpha",colorizer="ColorizerAttachToBuffer"}

local functions = {}

local function test_for_issues()
    if DEBUG_MODE_ENABLED then
        for opt_name in pairs(options) do
            if type(options[opt_name]) == "table" and not contains(DEBUG_QUERY_EXCEPTIONS,opt_name) then
                setmetatable(rawget(options,opt_name),{__index = function(self,field)
                    if contains(DEBUG_QUERY_EXCEPTIONS,field) then return end
                    if rawget(self,field) == nil then return require("notify")(("Missing sub option: %s for %s"):format(field,opt_name),"error") end
                    return rawget(self,field)
                end})
            end
        end
    end

    setmetatable(functions,{__index = function(_,key)
        if rawget(options,key) == nil then
            return require("notify")(("Missing 'core' option: %s"):format(key),"error")
        end
        return rawget(options,key)
    end})
end

local function init_plugins()
    local is_ok
    local mod

    local function setup_mod(filename)
        is_ok,mod = pcall(require,filename)

        if is_ok and type(mod) == "table" and mod.setup then
            mod.setup()
        end
    end

    local function require_mod(filename)
        setup_mod("core."..filename)

        if not is_ok then
            setup_mod(filename)
        end
    end

    local function load_mod(opt_name,data)
        local is_table = type(data) == "table"
        local is_enabled = is_table and data.enabled or not is_table and data
        local defer = is_table and data.defer and options.deferring_enabled and data.defer * 1000 or 0
        local path = (is_table and (data.path or data.paths)) or opt_name

        if not path then return end
        if not is_enabled then return end

        if type(path) == "table" then
            vim.defer_fn(function()
                for _,file_name in ipairs(path) do require_mod(file_name) end
            end,(defer and defer))
        elseif is_table then
            local func_name = FALLBACK_FUNC[path]

            if defer then
                vim.defer_fn(function()
                    require_mod(path)
                    if func_name and vim.cmd[func_name] and not vim.v.argv[3] then
                        vim.cmd[func_name]()
                    end
                end,defer)
            else
                if func_name and not vim.v.argv[3] and options.plugins.defer then
                    vim.defer_fn(vim.cmd[func_name],options.deferring_enabled and options.plugins.defer or 0)
                end
                require_mod(path)
            end
        end
    end

    for opt_name,obj in pairs(options) do load_mod(opt_name,obj) end
end

function functions:use_plugins()
    local nodefault = require "core.nodefault"

    if not nodefault.up_to_date then nodefault.init() end

    if not options.plugins.enabled then return end

    test_for_issues()

    local function init()
        require "user.plugins"

        init_plugins()

        if self.want_default_keybinds then
            require "core.use_keymaps"
        end
    end

    local success,err = pcall(function()
        if options.plugins.defer then
            vim.defer_fn(init,options.plugins.defer * 1000)
        else
            init()
        end
    end)

    if not success and type(err) == "string" then
        require("notify")(("Error with 'use_plugins': %s"):format(err),"error")
    end

    return self
end

function functions:use_visuals()
    local nodefault = require "core.nodefault"
    if not nodefault.up_to_date then nodefault.init()end

    if not options.plugins.enabled then return end

    local success,err = pcall(function()
        if self.color_scheme.allow_custom then
            vim.cmd.colorscheme(self.color_scheme.name)
            if (self.color_scheme.name == "material") then vim.g.material_style = self.color_scheme.arg end
        end

        if self.background.transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end

        if self["nvim-tree"].on_startup then
            vim.cmd.NvimTreeOpen()
        end
    end)


    for _,indent_name in ipairs(INDENT_BLANK_LINE_LIST) do
        vim.cmd("highlight "..indent_name .." guifg="..INDENTBLANKLINE_BACKGROUNDCOLOR.." gui=nocombine")
    end

    if options.want_leap then
        require('leap').add_default_mappings()
    end

    if not success and err then require("notify")(err,"error") end

    return self
end

return functions
