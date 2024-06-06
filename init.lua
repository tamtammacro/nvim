local ok, plugins = pcall(require, "core.load_plugins")

if not ok then return print "core.load_plugins module does not exist or error occurred" end

if not plugins then return print "load_plugins module did not return anything" end

xpcall(plugins.init, print)
