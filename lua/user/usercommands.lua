local functions = require "user.util_functions"

vim.api.nvim_buf_create_user_command(0, "CapWord",
  function(opts)
    functions.buf_cap_word()
  end,
  { nargs = 0 })
