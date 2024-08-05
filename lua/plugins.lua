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
    -- functionality --
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy"
    },

    {
        'stevearc/conform.nvim',
        event = "VeryLazy",
        opts = {},
    },

    {
        "ThePrimeagen/refactoring.nvim",
        event = "VeryLazy",
        dependancies = {
            { "nvim-lua/plenary.nvim" },
        }
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    {"folke/nvim-ts-autotag", event = "VeryLazy"},

    {
        'xeluxee/competitest.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('competitest').setup() end,
    },


    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = true
    },

    {"mbbill/undotree",event = "VeryLazy"},

    {"nvim-pack/nvim-spectre",event = "VeryLazy"},

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {}
    },

    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- {
    --     "epwalsh/obsidian.nvim",
    --     version = "*",
    --     lazy = true,
    --     ft = "markdown",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     opts = {
    --         workspaces = {
    --             {
    --                 name = "personal",
    --                 path = "~/vaults/personal",
    --             },
    --             {
    --                 name = "work",
    --                 path = "~/vaults/work",
    --             },
    --         },
    --     },
    -- },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    {"theprimeagen/harpoon",event = "VeryLazy"},
    {'simrat39/symbols-outline.nvim', event = "VeryLazy"},

    {
        'phaazon/hop.nvim',
        event = "VeryLazy",
        branch = 'v2',
        config = function()
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    },

    {
        'rmagatti/goto-preview',
        event = "VeryLazy",
        config = function()
            require('goto-preview').setup {}
        end
    },

    {
        'romgrk/barbar.nvim',
        event = "VeryLazy",
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
        event = "VeryLazy",
        config = function()
            require('treesj').setup({ use_default_keymaps = false })
        end,
    },

    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    -- visuals --
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependancies = { 'kyazdani42/nvim-web-devicons', opt = true }
    },

    {"anuvyklack/middleclass", event = "VeryLazy"},
    {"anuvyklack/animation.nvim", event = "VeryLazy"},

    {
        "folke/windows.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            --require('windows').setup()
            --vim.cmd.WindowsEnableAutowidth()
        end
    },

    {
        "folke/paint.nvim",
        event = "VeryLazy",
        config = function()
            require("paint").setup({
                -- ---@type PaintHighlight[]
                highlights = {
                    {
                        -- filter can be a table of buffer options that should match,
                        -- or a function called with buf as param that should return true.
                        -- The example below will paint @something in comments with Constant
                        filter = { filetype = "lua" },
                        pattern = "%s*%-%-%-%s*(@%w+)",
                        hl = "Constant",
                    },
                },
            })
        end,
    },

    {
        "folke/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup()
        end
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    {"folke/nui.nvim", event = "VeryLazy"},

    {
        'lukas-reineke/headlines.nvim',
        event = "VeryLazy",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
    },

    "kevinhwang91/promise-async",

    {"kevinhwang91/nvim-ufo", event = "VeryLazy"},

    {
        "anuvyklack/pretty-fold.nvim",
        event = "VeryLazy",
        config = function()
            require('pretty-fold').setup {
                keep_indentation = false,
                fill_char = '━',
                sections = {
                    left = {
                        '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
                    },
                    right = {
                        '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
                    }
                }
            }
        end
    },

    {'tamton-aquib/staline.nvim', event = "VeryLazy"},
    {'nvim-tree/nvim-web-devicons', event = "VeryLazy"},
    --{"HiPhish/nvim-ts-rainbow2", event = "VeryLazy"},

    {'NvChad/nvim-colorizer.lua', event = "VeryLazy"},

    {"uga-rosa/ccc.nvim", event = "VeryLazy"},

    {'rcarriga/nvim-notify',event = "VeryLazy"},
    -- {"folke/noice.nvim", event = "VeryLazy"},

    {"MunifTanjim/nui.nvim", event = "VeryLazy"},

    {"RRethy/vim-illuminate", event = "VeryLazy"},

    {"lukas-reineke/indent-blankline.nvim", event = "VeryLazy"},

    -- {
    --     "utilyre/barbecue.nvim",
    --     name = "barbecue",
    --     version = "*",
    --     dependencies = {
    --         "SmiteshP/nvim-navic",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     opts = {},
    -- },

    -- git integration --
    {"tpope/vim-fugitive", event = "VeryLazy"},

    {"lewis6991/gitsigns.nvim"},
    {"f-person/git-blame.nvim", event = "VeryLazy"},

    {"sindrets/diffview.nvim", event = "VeryLazy"},

    -- telescope --
    'nvim-lua/plenary.nvim',

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        event = "VeryLazy"
    },

    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', event = "VeryLazy" },
    { 'nvim-telescope/telescope-ui-select.nvim', event = "VeryLazy" },

    -- icons --
    {
        'goolord/alpha-nvim',
        event = "VeryLazy",
    },

    -- color schemes --
    {"gruvbox-community/gruvbox"},

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    { "catppuccin/nvim",  as = "catppuccin" },
    { "rose-pine/neovim", name = "rose-pine" },
    "EdenEast/nightfox.nvim",
    'Mofiqul/vscode.nvim',
    'folke/tokyonight.nvim',
    'marko-cerovac/material.nvim',
    {
        "water-sucks/darkrose.nvim",
        lazy = false,
        priority = 1000,
    },

    -- lsp --
    {
        "williamboman/mason.nvim",
        run = ":MasonUpdate",
        event = "VeryLazy",
    },

    -- { "folke/neodev.nvim", event="VeryLazy", opts = {} },

    {"jay-babu/mason-nvim-dap.nvim", event = "VeryLazy"},

    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, event = "VeryLazy" },

    {
        "ldelossa/nvim-dap-projects",
        event = "VeryLazy"
    },

    {"hrsh7th/cmp-nvim-lsp", event = "VeryLazy"},
    {"hrsh7th/cmp-buffer", event = "VeryLazy"},

    {"hrsh7th/cmp-path", event = "VeryLazy"},

    {"hrsh7th/cmp-cmdline", event = "VeryLazy"},
    {"neovim/nvim-lspconfig", event = "VeryLazy"},

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        event = "VeryLazy"
    },

    { "folke/trouble.nvim", event = "VeryLazy", opts = {}, cmd = "Trouble" },

    {
        'VonHeikemen/lsp-zero.nvim',
        event = "VeryLazy",
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
    -- 'IogaMaster/neocord',
    -- "andweeb/presence.nvim",

    -- file manager --
    {'prichrd/netrw.nvim', event = "VeryLazy"},
    {'stevearc/oil.nvim',event = "VeryLazy"},
    {'nvim-tree/nvim-tree.lua', event = "VeryLazy"},

    -- tree sitter --
    {
        'nvim-treesitter/nvim-treesitter',
        event = "VeryLazy",
        run = function()
            local M = require('nvim-treesitter.install')
            M.compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl", "zig" }
            M.prefer_git = false
            M.update({ with_sync = true })
        end,
    },

    {"nvim-treesitter/playground", event = "VeryLazy"},
    {"nvim-treesitter/nvim-treesitter-context", event = "VeryLazy"},

    {
        'olivercederborg/poimandres.nvim',
        event = "VeryLazy",
        config = function()
            require('poimandres').setup {}
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
