do
    local trouble_telescope = require("trouble.providers.telescope")
    local telescope = require("telescope")

    telescope.setup {
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble_telescope.open_with_trouble },
          n = { ["<c-t>"] = trouble_telescope.open_with_trouble },
        },
      },
    }
end

local trouble = require "trouble"

vim.keymap.set("n", "<leader>xx", function() trouble.open() end)
vim.keymap.set("n", "<leader>xw", function() trouble.open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.open("loclist") end)
vim.keymap.set("n", "gR", function() trouble.open("lsp_references") end)
--vim.keymap.set("n","<Space>t",vim.cmd.TroubleToggle)
