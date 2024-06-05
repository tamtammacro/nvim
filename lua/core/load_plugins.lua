local exports = {}
local options = require "plugin_settings"
local io_funcs = require "helper.io_func"
local funcs = require "helper.func"
local keymaps = require "keymaps"

local TOML = require "vendor.lua-toml.toml"

local notify_ok, notify = pcall(require, "notify")

if not notify_ok then return print "Could not load plugins: missing notify" end

local INDENT_BLANKLINE_BACKGROUND_COLOR = 0xFF0000
local INDENT_BLANK_LINE_LIST = { "IndentBlanklineContextChar", "IndentBlanklineChar", "IndentBlanklineSpaceChar",
    "IndentBlanklineSpaceCharBlankline", "IndentBlanklineContextSpaceChar", "IndentBlanklineContextStart" }
local FALLBACK_FUNC = { alpha = "Alpha", colorizer = "ColorizerAttachToBuffer" }
local keymap_loader = require "core.load_keymaps"

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
        setup_mod("core." .. filename)

        if not is_ok then
            setup_mod(filename)
        end
    end

    local function require_sub_mods(p_path)
        for _, file_name in pairs(p_path) do require_mod(file_name) end
    end

    local function load_mod(plugin_name, data)
        is_table = type(data) == "table"
        is_enabled = is_table and data.enabled or not is_table and data

        if not is_enabled then return end
        path = (is_table and (data.module or data.modules)) or plugin_name
        if not path then return end

        defer = is_table and data.defer and options.plugins.deferring_enabled and data.defer * 1000 or 0
        is_multi_path = type(path) == "table"

        if is_multi_path then
            if defer > 0 then
                vim.defer_fn(function() require_sub_mods(path) end, defer)
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
                end, defer)
            else
                if func_name and not vim.v.argv[3] and options.plugins.defer then
                    vim.defer_fn(vim.cmd[func_name], options.plugins.deferring_enabled and options.plugins.defer or 0)
                end
                require_mod(path)
            end
        end
    end

    for plugin_name, obj in pairs(options) do load_mod(plugin_name, obj) end
end

local function use_plugins(plugin_manager)
    if not options.plugins.enabled then return end

    local function init()
        if plugin_manager == "packer" then
            require "packer_plugins"
        else
            require "plugins"
        end
        xpcall(init_plugins, function(error) notify(error, "error") end)
    end

    local success, err = pcall(function()
        if options.plugins.defer then
            vim.defer_fn(init, options.plugins.defer * 1000)
        else
            init()
        end
    end)

    if not success and err then
        notify(("Error with 'use_plugins': %s"):format(err), "error")
    end
    xpcall(function()
        keymap_loader.load_keymaps()
    end, print)
end

local function use_visuals()
    if not options.plugins.enabled then return end

    local current_theme = vim.g.colors_name

    local success, err = pcall(function()
        local theme_full_name = options.theme.style and #options.theme.style > 0 and
            options.theme.name .. "-" .. options.theme.style or options.theme.name

        if options.theme.enabled and (current_theme ~= theme_full_name) then
            local success, error_message = pcall(vim.cmd.colorscheme, theme_full_name)

            if not success then
                notify(error_message, "error")
            end

            if (options.theme.name == "material") then vim.g.material_style = options.theme.style end
        end

        if options.theme.transparent then
            vim.cmd["highlight"]("Normal guibg=none")
        end
    end)

    for _, indent_name in ipairs(INDENT_BLANK_LINE_LIST) do
        vim.cmd("highlight " .. indent_name .. " guifg=" .. INDENT_BLANKLINE_BACKGROUND_COLOR .. " gui=nocombine")
    end

    if not success and err then notify(err, "error") end
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

    local settings_path = io_funcs.get_config_loc() .. (io_funcs.is_win32() and "\\settings" or "/settings")
    local path = settings_path .. "/plugin_settings.toml"

    if not io_funcs.isdir(settings_path) then
        io_funcs.mkdir(settings_path)
    end

    if not io_funcs.file_exists(path) then
        local str = TOML.encode(options)
        if io_funcs.write_file(path, make_string(str)) then
            print "INFO: Generated plugin settings file"
        end
    end

    path = io_funcs.get_config_loc() .. "/settings/keymaps.toml"

    if not io_funcs.file_exists(path) then
        local keymaps_copy = funcs.deepcopy(keymaps)
        keymaps_copy.VIM_COMMAND_PREFIX = nil
        keymaps_copy.LUA_COMMAND_PREFIX = nil
        keymaps_copy.EDITOR_COMMAND_PREFIX = nil
        local str = TOML.encode(keymaps_copy)
        if io_funcs.write_file(path, make_string(str)) then
            print "INFO: Generated keymaps file"
        end
    end
end

return exports
