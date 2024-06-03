local options = require "user.options"
local keymaps = require "user.keymaps"

local VIM_COMMAND_PREFIX = "v."
local modules = {}

local mod
local mod_ok

local function set_keymap(obj,func,args)
    if not func then return print "Something went wrong: function reference is nil for set_keymap" end
    xpcall(function()
        vim.keymap.set((obj.mode or "n"),obj.key,function() func(args) end,{desc = obj.desc or "unknown"})
    end,function(error_message)
        require "notify"(("Could not set keymap: %s"):format(error_message))
    end)
end

local function load_keymaps()
    local function load_module(t)
        mod = modules[t.category_name] or select(2,pcall(require,t.module))
        mod_ok = type(mod) == "table"

        if mod_ok and not modules[t.category_name] then
            modules[t.category_name] = mod
        end

        if mod_ok and rawget(mod,t.action_name) then
            set_keymap(t.data,rawget(mod,t.action_name))
        elseif mod_ok and t.data.cmd and not t.data.cmd:match("^"..VIM_COMMAND_PREFIX) and mod[t.data.cmd] then
            set_keymap(t.data,mod[t.data.cmd],t.action_name)
        end
    end

    for category_name, keymap_category_table in pairs(keymaps) do
        for action_name,data in pairs(keymap_category_table) do
            if options[category_name] ~= nil and options[category_name].enabled then
                if options[category_name].module then
                    load_module({category_name = category_name,data = data,action_name = action_name,module = options[category_name].module})
                elseif options[category_name].modules then
                    for _,module in ipairs(options[category_name].modules) do
                        load_module({category_name = category_name,data = data,action_name = action_name,module = module})
                    end
                end

                if data.cmd and data.cmd:match("^"..VIM_COMMAND_PREFIX) then
                    set_keymap(data,vim.cmd[data.cmd:sub(#VIM_COMMAND_PREFIX+1,#data.cmd)])
                end
            end
        end
    end
end

xpcall(load_keymaps,print)
