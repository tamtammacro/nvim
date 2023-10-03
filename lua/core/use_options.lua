local options = require "core.options"
local already_initilized = false

local autostart = {}
autostart.user = {"trouble"}
autostart.core = {"nodefault","tabnine"}

local functions = {}

local function is_element(t,e)
    for _,v in pairs(t) do
        if v == e then return true end
    end
end

local execeptions = {"background","color_scheme"}
local field_exceptions = {"path"}

for opt_name in pairs(options) do
    if not is_element(execeptions,opt_name) then
        if type(rawget(options,opt_name)) == "table" then
            setmetatable(rawget(options,opt_name),{__index = function(self,field)
                if is_element(field_exceptions,field) then return end

                if rawget(self,field) == nil then
                    return require("notify")(("Missing sub option: %s for %s"):format(field,opt_name),"error")
                end
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

local function initialize_default_plugins()
    local is_table
    local path
    local is_enabled

    local function load_mod(opt_name,value)
        is_table = type(value) == "table"
        is_enabled = is_table and value.enabled or not is_table and value
        path = is_table  and value.path or opt_name
        if not is_enabled then return end

        local dir_name = ""

        for key in pairs(autostart) do
            if is_element(autostart[key],path) then dir_name = key.."." end
        end

        local full_path = dir_name..path
        local is_ok,mod = pcall(require,full_path)

        if is_ok and type(mod) == "table" and mod.setup then mod.setup() end
    end

    for opt_name,obj in pairs(options) do
        load_mod(opt_name,obj)
    end
end

function functions:use_plugins()
    if already_initilized then return end

    local success,err = pcall(function()
        if self.want_lazy_plugins then require "user.lazyplugins" else require "user.plugins" end

        vim.g.barbar_auto_setup = false

        initialize_default_plugins()

        if self.lsp.enabled then
            require "core.cmp"
            require "core.lsp"
        end

        if self.my_user_commands_info.enabled then
            require "user.usercommands"
        end

        if self.want_tree_sitter then
            require "core.treesitter"
        end

        if self.want_default_keybinds then
            require "core.use_keybinds"
        end
    end)

    if not success and err then
        require("notify")(("Error while trying to 'use_plugins', with message: %s"):format(err),"error")
    end

    already_initilized = true
end

function functions:use_visuals()
    local success,err = pcall(function()
        if self.color_scheme.allow_custom then
            vim.cmd.colorscheme(self.color_scheme.name)
            if (self.color_scheme.name == "material") then vim.g.material_style = self.color_scheme.arg1 end
        end

        if self.background.is_transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end

        if self["nvim-tree"].on_startup then
            vim.cmd.NvimTreeOpen()
        end

        if self.want_lualine then
            require "lualine".setup()
        end
    end)
    if not success and err then print(err) end
end

return functions
