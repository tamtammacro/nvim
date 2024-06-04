local ok, autotag = pcall(require,"nvim-ts-autotag")

if not ok then return print "ts-autotag is not installed" end

autotag.setup({
    opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
    },
    per_filetype = {
        ["html"] = {
            enable_close = false
        }
    }
})

-- local TagConfigs = require("nvim-ts-autotag.config.init")
-- TagConfigs:add_alias("html")
