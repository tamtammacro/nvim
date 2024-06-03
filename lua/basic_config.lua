local vo = vim.o

xpcall(function()
    vo.number = true
    vo.background = "dark"
    vo.termguicolors = true
    vo.tabstop = 4
    vo.softtabstop = 4
    vo.shiftwidth = 4
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

    vim.opt.guicursor = ""

    vim.opt.nu = true
    vim.opt.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
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
