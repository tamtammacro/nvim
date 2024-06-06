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

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    "folke/nvim-ts-autotag",

    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('competitest').setup() end,
    },

    { "folke/neodev.nvim",       opts = {} },

    {
        "windwp/nvim-autopairs",
        config = true
    },

    "mbbill/undotree",
    "nvim-pack/nvim-spectre",
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {}
    },

    {
        "folke/twilight.nvim",
        opts = {
        }
    },

    {
        "iamcco/markdown-preview.nvim",
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
            require('treesj').setup({ use_default_keymaps = false })
        end,
    },

    { 'akinsho/toggleterm.nvim',                  version = "*", config = true },

    -- visuals --
    {
        'nvim-lualine/lualine.nvim',
        dependancies = { 'kyazdani42/nvim-web-devicons', opt = true }
    },

    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",

    {
        "folke/windows.nvim",
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
        config = function()
            require("paint").setup({
                ---@type PaintHighlight[]
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
        config = function()
            require("scrollbar").setup()
        end
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },

    "folke/nui.nvim",
    {
        'lukas-reineke/headlines.nvim',
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
    },

    "kevinhwang91/promise-async",
    "kevinhwang91/nvim-ufo",

    "rcarriga/nvim-notify",
    {
        "anuvyklack/pretty-fold.nvim",
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
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "f-person/git-blame.nvim",
    "sindrets/diffview.nvim",

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
        run = ":MasonUpdate"
    },
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

    { "folke/trouble.nvim", opts = {}, cmd = "Trouble" },

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
    --'IogaMaster/neocord',
    --"andweeb/presence.nvim",

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
