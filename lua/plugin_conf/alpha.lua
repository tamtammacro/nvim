local success,alpha = pcall(require,"alpha")

if not success then return error  "alpha is not installed" end

local preferences = require "preferences"
local style = ""

if style == "" or not style then
    alpha.setup(require'alpha.themes.startify'.config)
elseif style == "dashboard" then
    alpha.setup(require'alpha.themes.dashboard'.config)
end

if not vim.v.argv[3] then
    vim.cmd.Alpha()
end
