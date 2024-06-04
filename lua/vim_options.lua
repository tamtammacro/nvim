local vo = vim.o

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

    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.opt.guicursor = ""
    vim.opt.inccommand = "split"
    vim.opt.signcolumn = "yes"
    vim.opt.splitbelow = true
    vim.opt.splitright = true

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

    -- vim.opt.scrolloff = 8
    --vim.opt.signcolumn = "yes"
    vim.opt.isfname:append("@-@")
    vim.opt.updatetime = 50
    --vim.opt.colorcolumn = "80"
    vim.mapleader = " "

    vim.g.barbar_auto_setup = false

    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
end,function(error_message)
    print(error_message)
end)
