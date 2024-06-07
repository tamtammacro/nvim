local SPACE_S = "<Space>"
local LEADER_S = "<leader>"
local ENTER_S = "<CR>"

local ENTER = "cr"
local LEFT_ARROW = "left"
local RIGHT_ARROW = "right"
local UP_ARROW = "up"
local DOWN_ARROW = "down"

local ALT = function(key)
    return "<M-" .. key .. ">"
end

local ALT_SHIFT = function(key)
    return "<M-S-" .. key .. ">"
end

local CONTROL = function(key)
    return "<C-" .. key .. ">"
end

local CONTROL_SHIFT = function(key)
    return "<C-S-" .. key .. ">"
end

xpcall(function()
    local wk = require("which-key")

    wk.register({
        k = {
            name = "Document", -- optional group name
        },
        f = {
            name = "Find", -- optional group name
        },
        r = {
            name = "Refactor", -- optional group name
        },
        g = {
            name = "Go", -- optional group name
        },
        d = {
            name = "Debug", -- optional group name
        },
    }, { prefix = SPACE_S })
end, print)
