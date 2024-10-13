local ok,plugins = pcall(require, "core.load_plugins")

if not ok then
	return error(plugins)
elseif type(plugins) ~= "table" then
	return error("core.load_plugins returned invalid data type")
end

xpcall(plugins.init,error)
