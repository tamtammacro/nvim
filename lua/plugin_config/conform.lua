local ok, conform = pcall(require, "conform")

if not ok then return print "conform is not installed" end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        svelte = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        cpp = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        graphql = { { "prettierd", "prettier" } },
        java = { "google-java-format" },
        kotlin = { "ktlint" },
        ruby = { "standardrb" },
        markdown = { { "prettierd", "prettier" } },
        erb = { "htmlbeautifier" },
        html = { "htmlbeautifier" },
        bash = { "beautysh" },
        proto = { "buf" },
        rust = { "rustfmt" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        sh = { { "shellcheck" } },
    },
    -- format_on_save = {
    --     -- These options will be passed to conform.format()
    --     timeout_ms = 500,
    --     lsp_fallback = true,
    -- },
    -- format_after_save = {
    --     lsp_fallback = true,
    -- },
    formatters = {
        --     -- prettier = function(bufnr)
        --     --     local bufname = vim.api.nvim_buf_get_name(bufnr)
        --     --     local config = vim.fs.find(".custom-config.json", { upward = true, path = bufname })[1]
        --     --     local default = require("conform.formatters.prettier")
        --     --     if config then
        --     --         print("found config")
        --     --         return vim.tbl_deep_extend("force", default, {
        --     --             args = { "--stdin-filepath", "$FILENAME", "--config", config },
        --     --             cwd = function()
        --     --                 return vim.fs.dirname(config)
        --     --             end,
        --     --         })
        --     --     end
        --     -- end
        -- my_formatter = {
        --     -- This can be a string or a function that returns a string.
        --     -- When defining a new formatter, this is the only field that is required
        --     command = "my_cmd",
        --     -- A list of strings, or a function that returns a list of strings
        --     -- Return a single string instead of a list to run the command in a shell
        --     args = { "--stdin-from-filename", "$FILENAME" },
        --     -- If the formatter supports range formatting, create the range arguments here
        --     range_args = function(self, ctx)
        --         return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
        --     end,
        --     -- Send file contents to stdin, read new contents from stdout (default true)
        --     -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
        --     -- file is assumed to be modified in-place by the format command.
        --     stdin = true,
        --     -- A function that calculates the directory to run the command in
        --     cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
        --     -- When cwd is not found, don't run the formatter (default false)
        --     require_cwd = true,
        --     -- When stdin=false, use this template to generate the temporary file that gets formatted
        --     tmpfile_format = ".conform.$RANDOM.$FILENAME",
        --     -- When returns false, the formatter will not be used
        --     condition = function(self, ctx)
        --         return vim.fs.basename(ctx.filename) ~= "README.md"
        --     end,
        --     -- Exit codes that indicate success (default { 0 })
        --     exit_codes = { 0, 1 },
        --     -- Environment variables. This can also be a function that returns a table.
        --     env = {
        --         VAR = "value",
        --     },
        --     -- Set to false to disable merging the config with the base definition
        --     inherit = true,
        --     -- When inherit = true, add these additional arguments to the command.
        --     -- This can also be a function, like args
        --     prepend_args = { "--use-tabs" },
        -- },
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        conform.format({ bufnr = args.buf })
    end,
})
