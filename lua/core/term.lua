local success, toggleterm = pcall(require, "toggleterm")

if not success then return print "toggleterm is not installed" end

toggleterm.setup {
    shade_terminals = true,
    shade_filetypes = {},
    size = 13,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal"
}
