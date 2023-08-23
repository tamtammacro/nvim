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
	use 'jiangmiao/auto-pairs'
	use 'tpope/vim-surround'
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use({
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = function()
        require('treesj').setup({})
      end,
    })

    -- visuals --
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

    -- grep utils | telescope --
	use {
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- icons --
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}

    -- color schemes --
	use "gruvbox-community/gruvbox"
    use { "catppuccin/nvim", as = "catppuccin" }
	use "EdenEast/nightfox.nvim" 
	use 'Mofiqul/vscode.nvim'
	use 'folke/tokyonight.nvim'
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
      }
    }

	use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
		'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

    -- discord rpc --
    use 'andweeb/presence.nvim'

    -- file manager --
	use 'prichrd/netrw.nvim'
    -- tree sitter --
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end
    }
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")

    use {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {}
        end
    }
end)

do
    local _ = require "mason"
    if _ then _.setup() else error "Run :PackerSync" end
end
