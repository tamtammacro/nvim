local success,telescope = pcall(require,"telescope")

if not success then return print "telescope is not installed" end

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "cache",
            "CMakeFiles",
            "out",
            "vs",
            "vscode",
            "class",
            "pdf",
            "dll",
        },
    }
})

xpcall(function()
    telescope.load_extension("ui-select")
    --telescope.load_extension("noice")
end,print)
