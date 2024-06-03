local success,alpha = pcall(require,"alpha")

if not success then return print "alpha plugin is not installed" end

local options = require "options"
local which = options.startup_screen.which

if which == "" or not which then
    alpha.setup(require'alpha.themes.startify'.config)
elseif which == "dashboard" then
    alpha.setup(require'alpha.themes.dashboard'.config)
end
