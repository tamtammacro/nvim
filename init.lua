local plugin_loader_path = "core.load_plugins"

local ok,loader = pcall(require,plugin_loader_path)

if not ok then
	return error(loader)
elseif type(loader) ~= "table" then
	return error(string.format("%s did not return a table",plugin_loader_path))
end

xpcall(loader.init,error)
