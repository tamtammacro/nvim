local init_path = "core.init"

local ok,init = pcall(require,init_path)

if not ok or type(init) ~= "table" then
	return print(string.format("Error: %s:%s",init_path,tostring(init)))
end

xpcall(init.setup,print)
