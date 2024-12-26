local init_path = "core.init"

local ok,init_result = pcall(require,init_path)

if not ok or type(init_result) ~= "table" then
	return print(string.format("Error: %s:%s", init_path, tostring(init_result)))
end

xpcall(init_result.setup,print)
