local ok, conform = pcall(require, "conform")

if not ok then
	return print("conform is not installed")
end

-- require("conform").setup({
-- 	formatters_by_ft = {
-- 		lua = { "stylua" },
-- 		-- Conform will run multiple formatters sequentially
-- 		python = { "isort", "black" },
-- 		-- You can customize some of the format options for the filetype (:help conform.format)
-- 		rust = { "rustfmt", lsp_format = "fallback" },
-- 		-- Conform will run the first available formatter
-- 		javascript = { "prettierd", "prettier", stop_after_first = true },
-- 	},
-- 	format_on_save = {
-- 		-- These options will be passed to conform.format()
-- 		timeout_ms = 500,
-- 		lsp_fallback = true,
-- 	},
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		conform.format({ bufnr = args.buf })
-- 	end,
-- })
