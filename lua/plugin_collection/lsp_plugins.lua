return {
	{
		"williamboman/mason.nvim",
		run = ":MasonUpdate",
		event = "InsertEnter",
	},

	{ "folke/neodev.nvim", event = "InsertEnter", opts = {} },

	{ "folke/nvim-ts-autotag", event = "VeryLazy" },

	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" },

	{ "hrsh7th/cmp-path", event = "VeryLazy" },

	{ "hrsh7th/nvim-cmp", event = "InsertEnter" },

	{ "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },

	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "neovim/nvim-lspconfig", event = "InsertEnter" },

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		event = "InsertEnter",
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		event = "InsertEnter",
		branch = "v1.x",
		dependancies = {

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- -- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
		},
	},
}
