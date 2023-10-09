local options = require "user.options"

local already_using_plugins
local already_using_visuals
local debug_should_test_fields

local functions = {}

local function is_element(t,e)
    local i = 1
    local v = t[i]

    while v ~= nil do
        if v == e then return true end
        i = i + 1
        v = t[i]
    end
end

local function test_fields()
    local query_exceptions = {"background","color_scheme","path","paths","defer","which"}

    if debug_should_test_fields then
        for opt_name in pairs(options) do
            if type(options[opt_name]) == "table" and not is_element(query_exceptions,opt_name) then
                if type(rawget(options,opt_name)) == "table" then
                    setmetatable(rawget(options,opt_name),{__index = function(self,field)
                        if is_element(query_exceptions,field) then return end
                        if rawget(self,field) == nil then
                            return require("notify")(("Missing sub option: %s for %s"):format(field,opt_name),"error")
                        end
                        return rawget(self,field)
                    end})
                end
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
            -- if not is_ok then
            --     require "notify"(("ERROR WHILE LOADING PLUGIN: %s"):format(filename),"eror")
            -- end
        end
    end

    local function load_mod(opt_name,data)
        local is_table = type(data) == "table"
        local is_enabled = is_table and data.enabled or not is_table and data
        local defer = is_table and data.defer
        local path = (is_table and (data.path or data.paths)) or opt_name

        if not path then return end
        if not is_enabled then return end

        if type(path) == "table" then
            vim.defer_fn(function()
                for _,file_name in ipairs(path) do require_mod(file_name) end
            end,(defer and defer * 1000 or 0))
        elseif is_table then
            if defer then
                vim.defer_fn(function()
                    require_mod(path)
                    if path == "alpha" and not vim.v.argv[3] then
                        vim.cmd.Alpha()
                    elseif path == "colorizer" then
                        vim.cmd.ColorizerAttachToBuffer()
                    end
                end,defer * 1000)
            else
                if path == "alpha" and not vim.v.argv[3] and options.plugins.defer then
                    vim.defer_fn(vim.cmd.Alpha,options.plugins.defer)
                end
                require_mod(path)
            end
        end
    end
    for opt_name,obj in pairs(options) do load_mod(opt_name,obj) end
end

function functions:use_plugins()
    if already_using_plugins then return print"no chain calls use plugins" end

    local nodefault = require "core.nodefault"

    if not nodefault.up_to_date then nodefault.init() end

    if not options.plugins.enabled then return end

    test_fields()

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

    already_using_plugins = true

    return self
end

function functions:use_visuals()
    if already_using_visuals then return print"no chain calls use visuals" end

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

    vim.cmd [[highlight IndentBlanklineContextChar guifg=#C3251C gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineChar guifg=#FF0000 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#FF0000 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineSpaceCharBlankline guifg=#FF0000 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineContextSpaceChar guifg=#FF0000 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineContextStart guifg=#FF0000 gui=nocombine]]

    if options.want_leap then
        require('leap').add_default_mappings()
    end

    if not success and err and already_using_plugins then require("notify")(err,"error") end

    already_using_visuals = true

    return self
end

return functions
