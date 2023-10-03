local options = require "core.options"

require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = options.tabnine_info.debounce_ms,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
})

if options.tabnine_info.show_on_lualine then
    require('lualine').setup({
        tabline = {
            lualine_a = {},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        sections = {lualine_c = {'lsp_progress'}, lualine_x = {'tabnine'}}
    })
end
