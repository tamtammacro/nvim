return {
	{ 
        "nvim-tree/nvim-web-devicons", 
        event = "VeryLazy" 
    },
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependancies = { "kyazdani42/nvim-web-devicons", opt = true },
	},

	{ "anuvyklack/middleclass", event = "VeryLazy" },
	{ "anuvyklack/animation.nvim", event = "VeryLazy" },

    { "kshenoy/vim-signature", event = "VeryLazy" },

	-- discord
	-- { "andweeb/presence.nvim" },

	{ "nacro90/numb.nvim" },

	{
		"folke/windows.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			-- require("windows").setup()
			-- vim.cmd.WindowsEnableAutowidth()
		end,
	},

	{
		"folke/paint.nvim",
		event = "VeryLazy",
		config = function()
			require("paint").setup({
				-- ---@type PaintHighlight[]
				highlights = {
					{
						-- filter can be a table of buffer options that should match,
						-- or a function called with buf as param that should return true.
						-- The example below will paint @something in comments with Constant
						filter = { filetype = "lua" },
						pattern = "%s*%-%-%-%s*(@%w+)",
						hl = "Constant",
					},
				},
			})
		end,
	},

	{
		"folke/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("scrollbar").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{ "folke/nui.nvim", event = "VeryLazy" },

	{
		"lukas-reineke/headlines.nvim",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},

	"kevinhwang91/promise-async",

	{ "kevinhwang91/nvim-ufo", event = "VeryLazy" },

	{
		"anuvyklack/pretty-fold.nvim",
		event = "VeryLazy",
		config = function()
			require("pretty-fold").setup({
				keep_indentation = false,
				fill_char = "━",
				sections = {
					left = {
						"━ ",
						function()
							return string.rep("*", vim.v.foldlevel)
						end,
						" ━┫",
						"content",
						"┣",
					},
					right = {
						"┫ ",
						"number_of_folded_lines",
						": ",
						"percentage",
						" ┣━━",
					},
				},
			})
		end,
	},

	{ "tamton-aquib/staline.nvim", event = "VeryLazy" },
	-- {"HiPhish/nvim-ts-rainbow2", event = "VeryLazy"},

	{ "NvChad/nvim-colorizer.lua", event = "VeryLazy" },

	{ "uga-rosa/ccc.nvim", event = "VeryLazy" },

	{ "rcarriga/nvim-notify", event = "VeryLazy" },
	{ "folke/noice.nvim", event = "VeryLazy" },

	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },

	{ "RRethy/vim-illuminate", event = "VeryLazy" },

	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
	{
		"goolord/alpha-nvim",
		event = "VeryLazy",
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
