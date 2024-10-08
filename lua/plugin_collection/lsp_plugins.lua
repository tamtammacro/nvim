return {
	{
		"williamboman/mason.nvim",
		run = ":MasonUpdate",
		event = "VeryLazy",
	},

	{ "folke/neodev.nvim", event = "VeryLazy", opts = {} },

	-- { "folke/nvim-ts-autotag", event = "VeryLazy" },

	-- { "jay-babu/mason-nvim-dap.nvim", event = "VeryLazy" },
	--
	-- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, event = "VeryLazy" },
	--
	-- {
	-- 	"ldelossa/nvim-dap-projects",
	-- 	event = "VeryLazy",
	-- },
	--
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },

	{ "hrsh7th/cmp-path", event = "VeryLazy" },

	{ "hrsh7th/nvim-cmp" },

	{ "hrsh7th/cmp-nvim-lsp-signature-help" },

	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "neovim/nvim-lspconfig", event = "VeryLazy" },

	{
		"L3MON4D3/LuaSnip", -- Snippet engine
	},

	-- { "saadparwaiz1/cmp_luasnip" }, -- Snippet completions for LuaSnip

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},

	-- { "folke/trouble.nvim", event = "VeryLazy", opts = {}, cmd = "Trouble" },

	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VeryLazy",
		branch = "v1.x",
		dependancies = {

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = true,
	},

}
