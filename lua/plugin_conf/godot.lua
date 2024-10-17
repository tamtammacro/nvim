local file = require "helper.io_func"

local gdscript_config = {
    capabilities = {},
    settings = {}
}

if file.is_win32() then
    gdscript_config.cmd = {"ncat","localhost",os.getenv "GDScript_Port" or "6005"}
end

local ok, lspconfig = pcall(require, "lspconfig")

if not ok then return print "Godot missing lspconfig" end

if lspconfig.gdscript then
    lspconfig.gdscript.setup(gdscript_config)
else
    print("No field gdscript for lspconfig")
end
