local vo = vim.o
local preferences = require("preferences")

local SHIFT_TAB_SPACE = 4

xpcall(function()
	vo.number = true
	vo.background = "dark"
	vo.termguicolors = true
	vo.tabstop = SHIFT_TAB_SPACE
	vo.softtabstop = SHIFT_TAB_SPACE
	vo.shiftwidth = SHIFT_TAB_SPACE
	vo.smarttab = true
	vo.autoindent = true
	vo.mouse = "a"
	vo.cursorline = true
	vo.relativenumber = true
	--vo.scrolloff = 8
	vo.numberwidth = 6
	-- vo.timeoutlen = 500
	vo.updatetime = 200
	vo.wrap = true
	vo.clipboard = "unnamedplus"

	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	vim.opt.guicursor = ""
	vim.opt.inccommand = "split"
	vim.opt.signcolumn = "yes"
	vim.opt.splitbelow = true
	vim.opt.splitright = true
	vim.opt.encoding = "utf-8"

	vim.opt.nu = true
	vim.opt.relativenumber = true
	vim.opt.number = true

	vim.opt.tabstop = SHIFT_TAB_SPACE
	vim.opt.softtabstop = SHIFT_TAB_SPACE
	vim.opt.shiftwidth = SHIFT_TAB_SPACE
	vim.opt.expandtab = true

	vim.opt.smartindent = true

	vim.opt.wrap = false

	vim.opt.swapfile = false
	vim.opt.backup = false
	vim.opt.undofile = true

	vim.opt.hlsearch = false
	vim.opt.incsearch = true

	vim.opt.termguicolors = true

	vim.opt.tags = "./tags;/"
	vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- vim.opt.scrolloff = 8
	--vim.opt.signcolumn = "yes"
	vim.opt.isfname:append("@-@")
	vim.opt.updatetime = 50
	--vim.opt.colorcolumn = "80"
	vim.mapleader = " "

	vim.g.barbar_auto_setup = false

    preferences.editor.file_explorer.name = preferences.conf.template == "minimal" and "netrw" or preferences.editor.file_explorer.name

	if preferences.editor.file_explorer.name ~= "netrw" then
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1
	end

	vim.g.netrw_banner = 0
	vim.g.netrw_liststyle = 3
	vim.g.netrw_sftp_cmd = "scp"
	vim.g.netrw_http_cmd = "curl"

	vim.cmd("highlight EndOfBuffer ctermbg=none guibg=none")

	local INDENT_BLANK_LINE_LIST = {
		"IndentBlanklineContextChar",
		"IndentBlanklineChar",
		"IndentBlanklineSpaceChar",
		"IndentBlanklineSpaceCharBlankline",
		"IndentBlanklineContextSpaceChar",
		"IndentBlanklineContextStart",
	}
	local INDENT_BLANKLINE_BACKGROUND_COLOR = 0xFF0000
	for _, indent_name in ipairs(INDENT_BLANK_LINE_LIST) do
		vim.cmd("highlight " .. indent_name .. " guifg=" .. INDENT_BLANKLINE_BACKGROUND_COLOR .. " gui=nocombine")
	end
end, function(error_message)
	print(error_message)
end)
