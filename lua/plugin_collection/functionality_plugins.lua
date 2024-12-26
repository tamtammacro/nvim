return {
	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
		dependancies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

    {
      'Wansmer/treesj',
      event = {
          "BufReadPre",
      },
      dependencies = {
          'nvim-treesitter/nvim-treesitter',
      },
    },

    {
        "goolord/alpha-nvim",
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

	{"kevinhwang91/promise-async"},
	{ "mbbill/undotree", event = "VeryLazy" },

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
}
