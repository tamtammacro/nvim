local options = require "user.options"
local which = options.startup_screen.which

if which == "" or not which then
    require'alpha'.setup(require'alpha.themes.startify'.config)
elseif which == "dashboard" then
    require'alpha'.setup(require'alpha.themes.dashboard'.config)
end
