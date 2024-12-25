local success,barbar = pcall(require,"barbar")

if not success then return print "barbar is not installed" end

barbar.setup()
vim.keymap.set('n', '<M-left>',"BufferPrevious", { desc = 'barbar previous buffer' })
vim.keymap.set('n', '<M-right>',"BufferNext", { desc = 'barbar previous buffer' })
