local options = require "user.options"

local user_paths = {"toggle_term","trouble"}

local vo = vim.o

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
vo.scrolloff = 8
vo.numberwidth = 6
vo.timeoutlen = 500
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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
--vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
--vim.opt.colorcolumn = "80"
vim.mapleader = " "

local function setup_states()
    local is_table
    local path
    local is_enabled


    local function is_element(t,e)
        for _,v in pairs(t) do
            if v == e then return true end
        end
    end

    local function load_mod(opt_name,value)
        is_table = type(value) == "table"
        is_enabled = is_table and value.enabled or not is_table and value
        path = is_table  and value.path or opt_name
        if not is_enabled then return end

        local dir_name = ""
        if is_element(user_paths,path) then dir_name = "user." end

        local is_ok,mod = pcall(require,dir_name..path)

        if is_ok and type(mod) == "table" and mod.setup then mod.setup() end
    end

    for opt_name,obj in pairs(options) do
        load_mod(opt_name,obj)
    end
end

setup_states()

vim.g.barbar_auto_setup = false

if options["nvim-tree"].on_startup then
    vim.cmd.NvimTreeOpen()
end
