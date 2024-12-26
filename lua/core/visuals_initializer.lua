local M = {}

function M.setup()
    vim.api.nvim_create_augroup('MyColorSchemeGroup', { clear = true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'MyColorSchemeGroup',
      pattern = '*',
      callback = function()
        vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
      end
    })

    local success,error_message = pcall(vim.cmd.colorscheme, "rose-pine-main")

    if not success then
        print(error_message)
    end
	-- vim.cmd["highlight"]("Normal guibg=none")
end

return M
