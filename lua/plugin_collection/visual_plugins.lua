return {
	{ 
        "nvim-tree/nvim-web-devicons", 
        event = "VeryLazy" 
    },
	{ "nacro90/numb.nvim" },

    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

	{
		"folke/todo-comments.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{ "folke/nui.nvim", event = "VeryLazy" },
	{ "rcarriga/nvim-notify", event = "VeryLazy" },
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },
}
