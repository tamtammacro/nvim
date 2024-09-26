return {
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        event = "VeryLazy"
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', event = "VeryLazy" },
    { 'nvim-telescope/telescope-ui-select.nvim', event = "VeryLazy" },

}
