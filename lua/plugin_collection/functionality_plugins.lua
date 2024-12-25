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
      keys = { '<space>m', '<space>j', '<space>s' },
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('treesj').setup({use_default_keymaps = false})
      end,
    },

    {
        "farmergreg/vim-lastplace",
        event = {"BufReadPre"},
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
