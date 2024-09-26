local success,alpha = pcall(require,"alpha")

if not success then return print "alpha is not installed" end

local options = require "plugin_settings"
local style = options.alpha.style

if style == "" or not style then
    alpha.setup(require'alpha.themes.startify'.config)
elseif style == "dashboard" then
    alpha.setup(require'alpha.themes.dashboard'.config)
end

if not vim.v.argv[3] then
    vim.cmd.Alpha()
end
