local options = require "core.options"

local already_initilized = false

local functions = {}
setmetatable(functions,{__index = options})

local function initialize_default_plugins()
    local is_table
    local path
    local is_enabled
    local user_paths = {"trouble"}

    local function is_element(t,e)
        for _,v in pairs(t) do
            if v == e then return true end
        end
    end

    local function load_mod(opt_name,value)
        is_table = type(value) == "table"
        is_enabled = is_table and value.enabled or not is_table and value
        path = is_table  and value.path or opt_name
        if not is_enabled then return end

        local dir_name = ""
        if is_element(user_paths,path) then dir_name = "user." end

        local is_ok,mod = pcall(require,dir_name..path)

        if is_ok and type(mod) == "table" and mod.setup then mod.setup() end
    end

    for opt_name,obj in pairs(options) do
        load_mod(opt_name,obj)
    end
end

function functions:use_plugins()
    if already_initilized then return end

    if self.want_lazy_plugins then require "user.lazyplugins" else require "user.plugins" end

    vim.g.barbar_auto_setup = false

    initialize_default_plugins()

    if self.lsp.enabled then
        require "core.cmp"
        require "core.lsp"
    end

    if self.want_my_user_commands then
        require "user.usercommands"
    end

    if self.want_tree_sitter then
        require "core.treesitter"
    end

    if self.want_default_keybinds then
        require "core.use_keybinds"
    end

    already_initilized = true
end

function functions:use_visuals()
    require "core.nodefault"

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
end

return functions
