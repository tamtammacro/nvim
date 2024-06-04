local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    "rcarriga/nvim-notify",

    -- mason --
	{
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	},

    -- basic functionality --
	"mg979/vim-visual-multi",

    {
        "ThePrimeagen/refactoring.nvim",
        dependancies = {
            {"nvim-lua/plenary.nvim"},
        }
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    "theprimeagen/harpoon",
    'simrat39/symbols-outline.nvim',
    "mbbill/undotree",
    {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    },
    {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {}
      end
    },

    -- 'romgrk/barbar.nvim',

    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},


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

    {'akinsho/toggleterm.nvim', version = "*", config = true},

    -- visuals --
	{
		'nvim-lualine/lualine.nvim',
		dependancies = { 'kyazdani42/nvim-web-devicons', opt = true }
	},

    'tamton-aquib/staline.nvim',
    'nvim-tree/nvim-web-devicons',
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
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      opts = {
        -- configurations go here
      },
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
    {'nvim-telescope/telescope-ui-select.nvim' },

    -- icons --
	{
		'goolord/alpha-nvim',
		dependancies = { 'nvim-tree/nvim-web-devicons' }
	},

    -- color schemes --
	"gruvbox-community/gruvbox",
    { "catppuccin/nvim", as = "catppuccin" },
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
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},

        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/vim-vsnip'}
      }
    },

    -- -- discord rpc --
    'IogaMaster/neocord',

    -- file manager --
	'prichrd/netrw.nvim',
    'stevearc/oil.nvim',
	'nvim-tree/nvim-tree.lua',

    -- tree sitter --
    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --         local ts_update = require('nvim-treesitter.install')
    --         ts_update.compilers = { "clang" }
    --         ts_update.prefer_git = false
    --         ts_update.update({ with_sync = true })
    --     end,
    -- },
    --
    -- "nvim-treesitter/playground",
    -- "nvim-treesitter/nvim-treesitter-context",

    {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {}
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
