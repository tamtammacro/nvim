local M = {}
local preferences = require "preferences"

function M.setup()
    vim.api.nvim_create_augroup('MyColorSchemeGroup', { clear = true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'MyColorSchemeGroup',
      pattern = '*',
      callback = function()
        vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
      end
    })

	local current_theme = vim.g.colors_name

	local success,err = pcall(function()
		local theme_full_name = preferences.editor.theme.style
				and #plugin_settings.editor.theme.style > 0
				and preferences.editor.theme.name .. "-" .. preferences.editor.theme.style
			or preferences.editor.theme.name

		if preferences.editor.theme and (current_theme ~= theme_full_name) then
			local success, error_message = pcall(vim.cmd.colorscheme, theme_full_name)

			if not success then
				print(error_message)
			end

			if preferences.editor.theme.name == "material" then
				vim.g.material_style = preferences.editor.theme.style
			end
		end

		if preferences.editor.background.transparent then
			vim.cmd["highlight"]("Normal guibg=none")
		end

        vim.cmd("highlight EndOfBuffer ctermbg=none guibg=none")

        for _, indent_name in ipairs({
            "IndentBlanklineContextChar",
            "IndentBlanklineChar",
            "IndentBlanklineSpaceChar",
            "IndentBlanklineSpaceCharBlankline",
            "IndentBlanklineContextSpaceChar",
            "IndentBlanklineContextStart",
        }) do 
            vim.cmd("highlight " .. indent_name .. " guifg=" .. 0xFF0000 .. " gui=nocombine")
        end
	end)

	if not success and err then
		error(err)
	end
end

return M
