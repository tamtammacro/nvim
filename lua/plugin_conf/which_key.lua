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
    }, { prefix = "<Space>"})
end, print)
