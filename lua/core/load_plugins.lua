local options = require "user.options"
local notify = require"notify"

local INDENT_BLANKLINE_BACKGROUND_COLOR = 0xFF0000
local INDENT_BLANK_LINE_LIST = {"IndentBlanklineContextChar","IndentBlanklineChar","IndentBlanklineSpaceChar","IndentBlanklineSpaceCharBlankline","IndentBlanklineContextSpaceChar","IndentBlanklineContextStart"}
local FALLBACK_FUNC = {alpha = "Alpha",colorizer="ColorizerAttachToBuffer"}

local functions = setmetatable({},{__index = function(_self,key)
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

    local function require_sub_mods(path)
        for _,file_name in ipairs(path) do require_mod(file_name) end
    end

    local function load_mod(opt_name,data)
        is_table = type(data) == "table"
        is_enabled = is_table and data.enabled or not is_table and data
        defer = is_table and data.defer and options.plugins.deferring_enabled and data.defer * 1000 or 0
        path = (is_table and (data.path or data.paths)) or opt_name
        is_multi_path = type(path) == "table"

        if not path then return end
        if not is_enabled then return end

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

    for opt_name,obj in pairs(options) do load_mod(opt_name,obj) end
end

function functions:use_plugins()
    if not options.plugins.enabled then return nil end

    local function init()
        require "user.plugins"
        xpcall(init_plugins,function(error) notify(error,"error") end)
        require "core.load_keymaps"
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

    return self
end

function functions:use_visuals()
    if not options.plugins.enabled then return nil end

    local success,err = pcall(function()
        if self.color_scheme.allow_custom then
            vim.cmd.colorscheme(self.color_scheme.name)
            if (self.color_scheme.name == "material") then vim.g.material_style = self.color_scheme.style end
        end

        if self.background.transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end

        local nvim_tree_opts = self["nvim-tree"]

        if nvim_tree_opts.enabled then
            require("nvim-tree").setup{view = {side = nvim_tree_opts.side}}

            if nvim_tree_opts.on_startup then
                local main_window = vim.api.nvim_get_current_win()
                vim.cmd.NvimTreeOpen()
                vim.defer_fn(function() vim.api.nvim_set_current_win(main_window) end,50)
            end
        end
    end)

    for _,indent_name in ipairs(INDENT_BLANK_LINE_LIST) do
        vim.cmd("highlight "..indent_name .." guifg="..INDENT_BLANKLINE_BACKGROUND_COLOR.." gui=nocombine")
    end

    if not success and err then notify(err,"error") end

    return self
end

return functions
