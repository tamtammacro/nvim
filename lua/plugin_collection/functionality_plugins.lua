return {
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy"
    },

    {
        'stevearc/conform.nvim',
        event = "VeryLazy",
        opts = {},
    },

    {
        "ThePrimeagen/refactoring.nvim",
        event = "VeryLazy",
        dependancies = {
            { "nvim-lua/plenary.nvim" },
        }
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
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

    {"folke/nvim-ts-autotag", event = "VeryLazy"},

    {
        'xeluxee/competitest.nvim',
        event = "VeryLazy",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('competitest').setup() end,
    },


    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = true
    },

    {"mbbill/undotree",event = "VeryLazy"},

    {"nvim-pack/nvim-spectre",event = "VeryLazy"},

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {}
    },

    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/vaults/personal",
                },
                {
                    name = "work",
                    path = "~/vaults/work",
                },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    {"theprimeagen/harpoon",event = "VeryLazy"},
    {'simrat39/symbols-outline.nvim', event = "VeryLazy"},

    {
        'phaazon/hop.nvim',
        event = "VeryLazy",
        branch = 'v2',
        config = function()
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    },

    {
        'rmagatti/goto-preview',
        event = "VeryLazy",
        config = function()
            require('goto-preview').setup {}
        end
    },

    {
        'romgrk/barbar.nvim',
        event = "VeryLazy",
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0',
    },

    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'Wansmer/treesj',
        event = "VeryLazy",
        config = function()
            require('treesj').setup({ use_default_keymaps = false })
        end,
    },

    { 'akinsho/toggleterm.nvim', version = "*", config = true },
}
