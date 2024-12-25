return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "InsertEnter" },
        init = function()
            -- require "plugin_conf.treesitter" 
        end,
        -- event = { "BufReadPre", "BufNewFile" },
        -- run = function()
        --     local M = require('nvim-treesitter.install')
        --     M.compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl", "zig" }
        --     M.prefer_git = false
        --     M.update({ with_sync = true })
        -- end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        -- event = { "BufReadPre", "BufNewFile" },
        event = { "InsertEnter" },
    },
}
