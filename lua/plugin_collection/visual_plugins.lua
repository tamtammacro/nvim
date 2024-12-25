return {
	{ 
        "nvim-tree/nvim-web-devicons", 
        event = "VeryLazy" 
    },
    { "kshenoy/vim-signature", event = "VeryLazy" },

	-- discord
	-- { "andweeb/presence.nvim" },

	{ "nacro90/numb.nvim" },

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{ "folke/nui.nvim", event = "VeryLazy" },

	{"kevinhwang91/promise-async"},
	{ "rcarriga/nvim-notify", event = "VeryLazy" },
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },
}
