local ok, plugins = pcall(require, "core.load_plugins")

if not ok then return print("Error:", plugins) end

if type(plugins) ~= "table" then return end

if not plugins then return print "core.load_plugins module did not return anything" end

xpcall(plugins.init, print)
