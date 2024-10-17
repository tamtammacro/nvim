local M = {}

local preferences = require "preferences"

local keymap_init = require("core.keymap_initializer")
local plugin_init = require "core.plugin_initializer"
local visuals_init = require "core.visuals_initializer"

local vim_opt = require("vim_opt")
local vim_g = require("vim_g")

function M.setup()
	plugin_init.setup()
	visuals_init.setup()
    keymap_init.setup()

    vim_opt.setup()
    vim_g.setup()
end

return M
