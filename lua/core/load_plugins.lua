local exports = {}
local funcs = require "helper.func"
local plugin_settings = require "plugin_settings"
local io_funcs = require "helper.io_func"
local keymaps = require "keymaps"
local preferences = require "preferences"

local TOML = require "vendor.lua-toml.toml"

local deferred_items = {}

local function init_plugins()
    local is_ok
    local mod

    local is_table
    local is_enabled
    local defer
    local path
    local is_multi_path

    local function setup_mod(filename)
        is_ok, mod = pcall(require, filename)

        if is_ok and type(mod) == "table" and mod.setup then
            mod.setup()
        end
    end

    local function require_mod(filename)
        if type(filename) ~= "string" then
            print("Something went wrong:", filename, "is not a string")
            return
        end

        setup_mod(filename)

        if not is_ok then
            print(string.format("Could not load module: %s", filename))
            if mod then
                print(string.format("core.load_plugins, could not load module error: %s", mod))
            end
            setup_mod("plugin_config." .. filename)
        end
    end

    local function require_sub_mods(p_path)
        if type(p_path) == "string" then return require_mod(p_path) end
        for _, file_name in pairs(p_path) do require_mod(file_name) end
    end

    local function load_mod(data)
        is_table = type(data) == "table"
        is_enabled = is_table and data.enabled or not is_table and data

        if not is_enabled then return end
        path = (is_table and (data.module or data.modules))
        if not path then return end

        defer = is_table and data.defer and plugin_settings.__settings__.deferring_enabled and data.defer * 1000 or 0
        is_multi_path = type(path) == "table"

        if is_multi_path and is_table then
            if defer > 0 then
                if type(path) == "table" then
                    for _,path_v in pairs(path) do
                        table.insert(deferred_items, { path = path_v, defer = defer })
                    end
                end
            else
                require_sub_mods(path)
            end
        elseif not is_multi_path and is_table then
            if defer > 0 then
                table.insert(deferred_items, { path = path, defer = defer,is_multi = false })
            else
                require_mod(path)
            end
        end
    end

    for _, obj in pairs(plugin_settings) do load_mod(obj) end

    for index, element in ipairs(deferred_items) do
        vim.defer_fn(function()
            require_mod(element.path)
            table.remove(deferred_items,index)
        end, element.defer)
    end
end

local function use_plugins(plugin_manager)
    if not plugin_settings.__settings__.enabled then return end

    local function init()
        if plugin_manager == "packer" then
            require "packer_plugins"
        else
            require "plugins"
        end
        xpcall(init_plugins, function(error) print(error) end)
    end

    local success, err = pcall(function()
        if plugin_settings.__settings__.defer then
            vim.defer_fn(init, plugin_settings.__settings__.defer * 1000)
        else
            init()
        end
    end)

    if not success and err then
        print(("Error with 'use_plugins': %s"):format(err))
    end
    xpcall(function()
        require "core.load_keymaps".load_keymaps()
    end, print)
end

local function use_visuals()
    if not plugin_settings.__settings__.enabled then return end

    local current_theme = vim.g.colors_name

    local success, err = pcall(function()
        local theme_full_name = preferences.theme.style and #plugin_settings.theme.style > 0 and
            preferences.theme.name .. "-" .. preferences.theme.style or preferences.theme.name

        if preferences.theme.enabled and (current_theme ~= theme_full_name) then
            local success, error_message = pcall(vim.cmd.colorscheme, theme_full_name)

            if not success then
                print(error_message)
            end

            if (preferences.theme.name == "material") then vim.g.material_style = preferences.theme.style end
        end

        if preferences.background.transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end
    end)

    if not success and err then print(err) end
end

local function make_string(s)
    local result = ""

    local ip = 0

    while ip < #s do
        ip = ip + 1

        if s:sub(ip, ip) == "\n" and s:sub(ip - 1, ip - 1) ~= "]" and s:sub(ip + 1, ip + 1) == "[" then
            result = result .. "\n"
        end

        result = result .. s:sub(ip, ip)
    end

    return result
end

function exports.init(plugin_manager)
    require "vim_options"
    use_plugins(plugin_manager)
    use_visuals()

    if not io_funcs.isdir(plugin_settings.__metadata__.folder_path) then
        io_funcs.mkdir(plugin_settings.__metadata__.folder_path)
    end

    if not io_funcs.file_exists(plugin_settings.__metadata__.path) or plugin_settings.__metadata__.out_of_date then
        local out_of_date_prev = plugin_settings.__metadata__.out_of_date

        local copy = funcs.deepcopy(plugin_settings)
        copy.__metadata__ = nil

        local str = TOML.encode(copy)

        if io_funcs.write_file(plugin_settings.__metadata__.path, make_string(str)) then
            if out_of_date_prev then
                print(("INFO: %s was updated"):format(plugin_settings.__metadata__.file_name))
            else
                print(("INFO: Generated %s"):format(plugin_settings.__metadata__.file_name))
            end
        end
    end

    if not io_funcs.file_exists(keymaps.__metadata__.path) or keymaps.__metadata__.out_of_date then
        local out_of_date_prev = keymaps.__metadata__.out_of_date

        keymaps.__cmd_types__ = nil
        local copy = funcs.deepcopy(keymaps)
        copy.__metadata__ = nil

        local str = TOML.encode(copy)

        if io_funcs.write_file(keymaps.__metadata__.path, make_string(str)) then
            if out_of_date_prev then
                print(("INFO: %s was updated"):format(keymaps.__metadata__.file_name))
            else
                print(("INFO: Generated %s"):format(keymaps.__metadata__.file_name))
            end
        end
    end

    if not io_funcs.file_exists(preferences.__metadata__.path) or preferences.__metadata__.out_of_date then
        local out_of_date_prev = preferences.__metadata__.out_of_date
        local copy = funcs.deepcopy(preferences)
        copy.__metadata__ = nil

        local str = TOML.encode(copy)

        if io_funcs.write_file(preferences.__metadata__.path, make_string(str)) then
            if out_of_date_prev then
                print(("INFO: %s was updated"):format(preferences.__metadata__.file_name))
            else
                print(("INFO: Generated %s"):format(preferences.__metadata__.file_name))
            end
        end
    end

    if not vim.v.argv[3] then
        require("persistence").load()
    end

    vim.defer_fn(function()
        if not plugin_settings.git.gitblame_inline then
            pcall(vim.cmd.GitBlameDisable)
        end
    end,500)
end

return exports
