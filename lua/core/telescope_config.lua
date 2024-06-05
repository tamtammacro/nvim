local success,telescope = pcall(require,"telescope")

if not success then return print "telescope is not installed" end

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            'git',
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

telescope.load_extension("ui-select")
telescope.load_extension("undo")
telescope.load_extension("noice")
