local success, config = pcall(require, "nvim-treesitter.configs")

if not success then return end

config.setup {
    ensure_installed = { "c", "go", "lua", "vim", "vimdoc", "query", "markdown", "rust", "javascript" },

    rainbow = {
        enable = false,
        disable = { 'jsx', 'cpp', "c" },
        query = 'rainbow-parens',
        strategy = require('ts-rainbow').strategy.global,
    },

    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { "html", "xml" },
    },

    sync_install = false,
    auto_install = false,
    ignore_install = { "javascript" },

    highlight = {
        enable = true,
        disabled_t = { "c", "rust"},
        disable = function(lang, buf)
            if vim.api.nvim_buf_get_option(0, "filetype") ~= "TelescopePrompt" then
                if lang == "cpp" then
                    vim.cmd.TSDisable "rainbow"
                else 
                    vim.cmd.TSEnable "rainbow"
                end
            end
            local max_filesize = 100 * 1024     -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
}
