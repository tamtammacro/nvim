local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    "rcarriga/nvim-notify",

    -- mason --
    {
        "williamboman/mason.nvim",
        run = ":MasonUpdate"
    },

    -- basic functionality --
    "mg979/vim-visual-multi",

    {
        'stevearc/conform.nvim',
        opts = {},
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependancies = {
            { "nvim-lua/plenary.nvim" },
        }
    },

    "windwp/nvim-ts-autotag",

    {
        "windwp/nvim-autopairs",
        config = true
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    "theprimeagen/harpoon",
    'simrat39/symbols-outline.nvim',
    "mbbill/undotree",
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    },
    {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    },

    {
        'romgrk/barbar.nvim',
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0',
    },

    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'Wansmer/treesj',
        config = function()
            require('treesj').setup({})
        end,
    },

    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    -- visuals --
    {
        'nvim-lualine/lualine.nvim',
        dependancies = { 'kyazdani42/nvim-web-devicons', opt = true }
    },

    'tamton-aquib/staline.nvim',
    'nvim-tree/nvim-web-devicons',
    "HiPhish/nvim-ts-rainbow2",
    'NvChad/nvim-colorizer.lua',
    "uga-rosa/ccc.nvim",
    'rcarriga/nvim-notify',
    "folke/noice.nvim",

    "MunifTanjim/nui.nvim",
    "RRethy/vim-illuminate",
    "lukas-reineke/indent-blankline.nvim",

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },

    -- git integration --
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- telescope --
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
    },

    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- icons --
    {
        'goolord/alpha-nvim',
        dependancies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- color schemes --
    "gruvbox-community/gruvbox",
    { "Mofiqul/dracula.nvim" },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    { "catppuccin/nvim",     as = "catppuccin" },
    { "rose-pine/neovim",    name = "rose-pine" },
    "EdenEast/nightfox.nvim",
    'Mofiqul/vscode.nvim',
    'folke/tokyonight.nvim',
    'marko-cerovac/material.nvim',

    -- lsp --
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "neovim/nvim-lspconfig",

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    { "folke/trouble.nvim" },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependancies = {

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' }
        }
    },

    -- -- discord rpc --
    'IogaMaster/neocord',

    -- file manager --
    'prichrd/netrw.nvim',
    'stevearc/oil.nvim',
    'nvim-tree/nvim-tree.lua',

    -- tree sitter --
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local M = require('nvim-treesitter.install')
            M.compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl", "zig" }
            M.prefer_git = false
            M.update({ with_sync = true })
        end,
    },

    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",

    {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {}
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
