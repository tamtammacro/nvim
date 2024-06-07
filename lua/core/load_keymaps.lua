local module_export = {}
local options = require "plugin_settings"
local keymaps = require "keymaps"

local modules = {}

local mod
local mod_ok

local function set_keymap(obj,func,opts,args)
    if obj.key == nil then return end
    if not func then return print "Something went wrong: function reference is nil for set_keymap" end

    opts = opts or {}
    opts.noremap = true
    opts.silent = true
    opts.desc = obj.desc or "No description"

    local command = type(func) == "string" and func:match("^"..keymaps.EDITOR_COMMAND_PREFIX) and func:sub(#keymaps.EDITOR_COMMAND_PREFIX+1,#func)

    xpcall(function()
        vim.keymap.set(obj.mode or "n",obj.key,command or function()
            if type(func) == "string" then
                loadstring(func)()
            else
                func(type(args) ~= "function" and args or args and args())
            end
        end,
        opts)
    end,function(error_message)
        require "notify"(("Could not set keymap: %s"):format(error_message))
    end)
end

-- TODO: add keymap target category --
function module_export.load_keymaps(_,external_opts)
    local function load_module(t)
        mod = modules[t.category_name] or select(2,pcall(require,t.module))
        mod_ok = type(mod) == "table"

        if not mod_ok then
            mod = modules[t.category_name] or select(2,pcall(require,"plugin_config."..t.module))
            mod_ok = type(mod) == "table"
        end

        if mod_ok and not modules[t.category_name] then
            modules[t.category_name] = mod
        end

        if mod_ok and rawget(mod,t.action_name) then
            set_keymap(t.data,rawget(mod,t.action_name),t.opts)
        elseif mod_ok and t.data.cmd and not t.data.cmd:match("^"..keymaps.VIM_COMMAND_PREFIX) and mod[t.data.cmd] then
            set_keymap(t.data,mod[t.data.cmd],t.opts,t.action_name)
        end
    end

    for category_name, keymap_category_table in pairs(keymaps) do
        if type(keymap_category_table) == "table" then
            for action_name,data in pairs(keymap_category_table) do
                if options[category_name] ~= nil and options[category_name].enabled then
                    if options[category_name].module then
                        load_module({category_name = category_name,data = data,action_name = action_name,module = options[category_name].module,opts = external_opts})
                    elseif options[category_name].modules then
                        for _,module in pairs(options[category_name].modules) do
                            load_module({category_name = category_name,data = data,action_name = action_name,module = module,opts = external_opts})
                        end
                    end

                    if data.cmd and data.cmd:match("^"..keymaps.VIM_COMMAND_PREFIX) then
                        set_keymap(data,vim.cmd[data.cmd:sub(#keymaps.VIM_COMMAND_PREFIX+1,#data.cmd)])
                    end

                    if data.cmd and data.cmd:match("^"..keymaps.LUA_COMMAND_PREFIX) then
                        set_keymap(data,data.cmd:sub(#keymaps.LUA_COMMAND_PREFIX+1,#data.cmd))
                    end

                    if data.cmd and data.cmd:match("^"..keymaps.EDITOR_COMMAND_PREFIX) then
                        set_keymap(data,data.cmd)
                    end
                end
            end
        end
    end
end


return module_export
