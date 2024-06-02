local options = require "user.options"
local keymaps = require "user.keymaps"

local VIM_COMMAND_PREFIX = "v."
local modules = {}

local mod
local mod_ok

local function set_keymap(obj,func)
    if not func then return print "Something went wrong: function reference is nil for set_keymap" end
    xpcall(function()
        vim.keymap.set((obj.mode or "n"),obj.key,func)
    end,function(error_message)
        require "notify"(("Could not set keymap: %s"):format(error_message))
    end)
end

local function load_keymaps()
    for category_name, keymap_category_table in pairs(keymaps) do
        for action_name,data in pairs(keymap_category_table) do
            if options[category_name] ~= nil and options[category_name].enabled then
                if options[category_name].path then
                    mod = modules[category_name] or select(2,pcall(require,options[category_name].path))
                    mod_ok = type(mod) == "table"

                    if mod_ok and not modules[category_name] then
                        modules[category_name] = mod
                    end

                    if mod_ok and rawget(mod,action_name) then
                        set_keymap(data,rawget(mod,action_name))
                    elseif mod_ok and data.cmd and not data.cmd:match("^"..VIM_COMMAND_PREFIX) and mod[data.cmd] then
                        -- TODO: add support for function arguments --
                        set_keymap(data,mod[data.cmd])
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
