local strings = require "user.utils.strings"
local functions = require "user.util_functions"
local options = require "core.options"

if not options.my_user_commands then return end

vim.api.nvim_buf_create_user_command(0, strings.capitilize_word(options.my_user_commands_info.prefix or "",false).."CapWord",
  function()
    functions.buf_cap_word()
  end,
  { nargs = 0 })
