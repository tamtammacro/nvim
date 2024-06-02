local options = require "user.options"
local notify = require "notify"

local INDENT_BLANKLINE_BACKGROUND_COLOR = 0xFF0000
local INDENT_BLANK_LINE_LIST = {"IndentBlanklineContextChar","IndentBlanklineChar","IndentBlanklineSpaceChar","IndentBlanklineSpaceCharBlankline","IndentBlanklineContextSpaceChar","IndentBlanklineContextStart"}
local FALLBACK_FUNC = {alpha = "Alpha",colorizer="ColorizerAttachToBuffer"}

local functions = setmetatable({},{__index = function(_,key)
    if not rawget(options,key) then return notify(("Missing 'core' option: %s"):format(key),"error") end
    return rawget(options,key)
end})

local function init_plugins()
    local is_ok
    local mod

    local is_table
    local is_enabled
    local defer
    local path
    local is_multi_path

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

    local function require_sub_mods(p_path)
        for _,file_name in ipairs(p_path) do require_mod(file_name) end
    end

    local function load_mod(plugin_name,data)
        is_table = type(data) == "table"
        is_enabled = is_table and data.enabled or not is_table and data

        if not is_enabled then return end
        path = (is_table and (data.path or data.paths)) or plugin_name
        if not path then return end

        defer = is_table and data.defer and options.plugins.deferring_enabled and data.defer * 1000 or 0
        is_multi_path = type(path) == "table"

        if is_multi_path then
            if defer > 0 then
                vim.defer_fn(function() require_sub_mods(path) end,defer)
            else
                require_sub_mods(path)
            end
        elseif is_table then
            local func_name = FALLBACK_FUNC[path]

            if defer > 0 then
                vim.defer_fn(function()
                    require_mod(path)
                    if func_name and vim.cmd[func_name] and not vim.v.argv[3] then
                        vim.cmd[func_name]()
                    end
                end,defer)
            else
                if func_name and not vim.v.argv[3] and options.plugins.defer then
                    vim.defer_fn(vim.cmd[func_name],options.plugins.deferring_enabled and options.plugins.defer or 0)
                end
                require_mod(path)
            end
        end
    end

    for plugin_name,obj in pairs(options) do load_mod(plugin_name,obj) end
end

function functions:use_plugins()
    if not options.plugins.enabled then return end

    local function init()
        require "user.plugins"
        xpcall(init_plugins,function(error) notify(error,"error") end)
    end

    local success,err = pcall(function()
        if options.plugins.defer then
            vim.defer_fn(init,options.plugins.defer * 1000)
        else
            init()
        end
    end)

    if not success and err then
        notify(("Error with 'use_plugins': %s"):format(err),"error")
    end

    require "core.load_keymaps"
end

function functions:use_visuals()
    if not options.plugins.enabled then return end

    local success,err = pcall(function()
        if self.color_scheme.allow_custom then
            local theme_name = self.color_scheme.style and #self.color_scheme.style > 0 and self.color_scheme.name.."-"..self.color_scheme.style or self.color_scheme.name
            local success = pcall(vim.cmd.colorscheme,theme_name)

            if not success then
                notify("Could not find color scheme: "..theme_name,"warning")
                local error_message
                success,error_message = pcall(vim.cmd.colorscheme,self.color_scheme.name)

                if not success then
                    notify(error_message,"error")
                end
            end

            if (self.color_scheme.name == "material") then vim.g.material_style = self.color_scheme.style end
        end

        if self.background.transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end
    end)

    for _,indent_name in ipairs(INDENT_BLANK_LINE_LIST) do
        vim.cmd("highlight "..indent_name .." guifg="..INDENT_BLANKLINE_BACKGROUND_COLOR.." gui=nocombine")
    end

    if not success and err then notify(err,"error") end
end

return functions
