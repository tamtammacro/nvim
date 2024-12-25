return {
	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
		dependancies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{ "mbbill/undotree", event = "VeryLazy" },

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
}
