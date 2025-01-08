local projectFolder = vim.fn.getcwd() .. "/project.godot"

if not projectFolder then return end

local os_info = vim.loop.os_uname()
-- vim.fn.serverstart "./godothost"

if os_info.sysname == "Linux" or os_info.sysname == "Darwin" then
    vim.g.godot_executable = os.getenv("HOME") .. "/godot/Godot"
elseif os_info.sysname == "Windows" then
    vim.g.godot_executable = "C:/godot/Godot.exe"
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

if not capabilities then
    return print("Failed to find capabilities module in godot.lua")
end

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.signatureHelp = {
    dynamicRegistration = true,
    signatureInformation = {
        documentationFormat = { "markdown", "plaintext" },
        parameterInformation = { labelOffsetSupport = true },
    },
}

if os_info.sysname == "Windows"  then
    capabilities.cmd = {"ncat","localhost",os.getenv "GDScript_Port" or "6005"}
end

local ok, lspconfig = pcall(require, "lspconfig")

if not ok then return print "Godot missing lspconfig" end

if lspconfig.gdscript then
    lspconfig.gdscript.setup(capabilities)
else
    print("No property 'gdscript' for lspconfig")
end
