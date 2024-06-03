require("packer").startup(function(use)
    -- main plugin manager --
	use "wbthomason/packer.nvim"

    -- mason --
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}

    -- basic functionality --
	use "mg979/vim-visual-multi"

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
        }
    }

	use 'jiangmiao/auto-pairs'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
	--use 'tpope/vim-surround'
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use("theprimeagen/harpoon")
    use 'simrat39/symbols-outline.nvim'
    use("mbbill/undotree")
    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }
    use {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {}
      end
    }

    use 'romgrk/barbar.nvim'
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

    use {
      'stevearc/oil.nvim'
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use({
      'Wansmer/treesj',
      config = function()
        require('treesj').setup({})
      end,
    })

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    -- visuals --
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
    use 'nvim-tree/nvim-web-devicons'
    use 'NvChad/nvim-colorizer.lua'
    use "uga-rosa/ccc.nvim"
    use 'rcarriga/nvim-notify'
    use "folke/noice.nvim"
    use "MunifTanjim/nui.nvim"
    use "RRethy/vim-illuminate"
    use "lukas-reineke/indent-blankline.nvim"

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    -- git integration --
    use("tpope/vim-fugitive")
    use "lewis6991/gitsigns.nvim"

    -- telescope --
	use {
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.6',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope-ui-select.nvim' }

    -- icons --
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' }
	}

    -- color schemes --
	use "gruvbox-community/gruvbox"
    use { "catppuccin/nvim", as = "catppuccin" }
	use "EdenEast/nightfox.nvim"
	use 'Mofiqul/vscode.nvim'
	use 'folke/tokyonight.nvim'
    use 'marko-cerovac/material.nvim'

    -- lsp -- 
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "neovim/nvim-lspconfig"
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        { "folke/trouble.nvim" },

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
    }

    -- -- discord rpc --
    use 'andweeb/presence.nvim'

    -- file manager --
	use 'prichrd/netrw.nvim'
	use 'nvim-tree/nvim-tree.lua'

    -- tree sitter --
    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --         local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    --         ts_update()
    --     end,
    -- }
     -- use("nvim-treesitter/playground")
     -- use("nvim-treesitter/nvim-treesitter-context")

    use {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {}
        end
    }
end)

local success,_ = pcall(require, "mason")
if success then _.setup() else error "Run :PackerSync" end
