return {
    {
        "gruvbox-community/gruvbox",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    {
        "catppuccin/nvim",
        as = "catppuccin",
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    "EdenEast/nightfox.nvim",
    'Mofiqul/vscode.nvim',
    'folke/tokyonight.nvim',
    'marko-cerovac/material.nvim',
    {
        "water-sucks/darkrose.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        'olivercederborg/poimandres.nvim',
        event = "VeryLazy",
        config = function()
            require('poimandres').setup {}
        end
    }
}
