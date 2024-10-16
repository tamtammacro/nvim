local vo = vim.opt
local preferences = require("preferences")

xpcall(function()
	vo.number = true
	vo.background = "dark"
	vo.termguicolors = true

	vo.tabstop = 4
	vo.softtabstop = 4
	vo.shiftwidth = 4

	vo.smarttab = true
	vo.smartindent = true
	vo.expandtab = true

	vo.autoindent = true
	vo.mouse = "a"
	vo.cursorline = true
	vo.number = true
	vo.nu = true
	vo.relativenumber = true
	vo.numberwidth = 6
	vo.timeoutlen = 500
	vo.updatetime = 200
	vo.wrap = true
	vo.clipboard = "unnamedplus"

    vo.syntax = "on"
    vo.ruler = true
    vo.title = true
    vo.hidden = true
    vo.ttimeoutlen = 0
    vo.wildmenu = true
    vo.showcmd = true
    vo.showmatch = true
    vo.inccommand = "split"
    vo.splitright = true
    vo.splitbelow = true

	vo.foldcolumn = "1" 
	vo.foldlevel = 99 
	vo.foldlevelstart = 99
	vo.foldenable = true

	vo.guicursor = ""
	vo.inccommand = "split"
	vo.signcolumn = "yes"
	vo.splitbelow = true
	vo.splitright = true
	vo.encoding = "UTF-8"

	vo.swapfile = false
	vo.backup = false
	vo.undofile = true

	vo.hlsearch = false
	vo.incsearch = true

	vo.tags = "./tags;/"
	vo.omnifunc = "v:lua.vim.lsp.omnifunc"

	vim.scrolloff = 8
	vo.isfname:append("@-@")
	vo.updatetime = 50
	vim.mapleader = " "

    preferences.editor.file_explorer.name = preferences.conf.template == "minimal" and "netrw" 
    or 
    preferences.editor.file_explorer.name

	if preferences.editor.file_explorer.name ~= "netrw" then
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1
	end

	vim.g.netrw_banner = 0
	vim.g.netrw_liststyle = 3
	vim.g.netrw_sftp_cmd = "scp"
	vim.g.netrw_http_cmd = "curl"

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
end,error)
