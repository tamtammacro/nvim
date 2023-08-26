local utils = {}

local strings = require "user.utils.strings"
local notify = require "notify"

function utils.buf_cap_word()
    local current_line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local word = select(2,pcall(strings.get_word_by_index,current_line,col+1))

    if not word then return notify("not a word") end

    local new_line = current_line:gsub(word,strings.capitilize_word(word,true))

    vim.api.nvim_buf_set_lines(0, row-1, row, true, {new_line})
end

return utils
