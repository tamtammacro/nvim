local M = {}

function M.setup()
	local success
	local lspconfig

	success, lspconfig = pcall(require, "lspconfig")
	if not success then
		return print("lspconfig is not installed")
	end

	local function on_attach(_, bufnr)
		local opts = {buffer = bufnr, remap = false}
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

	capabilities.textDocument.signatureHelp = {
		dynamicRegistration = true,
		signatureInformation = {
			documentationFormat = { "markdown", "plaintext" },
			parameterInformation = { labelOffsetSupport = true },
		},
	}

	lspconfig.clangd.setup({
		on_attach = on_attach,
		capabilities = capabilities,

		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
		},
		filetypes = { "c", "cpp", "objc", "objcpp" },
	})

	local lsp
	success, lsp = pcall(require, "lsp-zero")

	if not success then
		return print("lsp zero is not installed")
	end

	vim.lsp.set_log_level("debug")

	lsp.preset("recommended")
	lsp.ensure_installed({})
	lsp.nvim_workspace()

	local cmp

	success, cmp = pcall(require, "cmp")

	if not success then
		return print("cmp is not installed")
	end

	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	})

	cmp_mappings["<Tab>"] = nil
	cmp_mappings["<S-Tab>"] = nil

	lsp.setup_nvim_cmp({
		mapping = cmp_mappings,
	})

	lsp.set_preferences({
		suggest_lsp_servers = false,
		sign_icons = {
			error = "E",
			warn = "W",
			hint = "H",
			info = "I",
		},
	})

	lsp.on_attach(on_attach)
	lsp.setup()

    -- lsp.extend_lspconfig({
    --   sign_text = true,
    --   lsp_attach = on_attach,
    --   capabilities = capabilities
    -- })

	vim.diagnostic.config({
		virtual_text = true,
	})

	cmp.setup({
		snippet = {
			expand = function(args)
				local luasnip = require("luasnip")
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" }, -- Signature help source
			{ name = "luasnip" }, -- Snippet completions
		},
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})
end

vim.keymap.set('n', '<Space>fsr', ":lua vim.lsp.buf.references()<cr>", { desc = 'Find Symbol references' })

vim.keymap.set('n', '<Space>fsw', ":lua vim.lsp.buf.workspace_symbol()<cr>", { desc = 'Find Symbol workspace' })

-- vim.keymap.set('n', '<Space>rr',function()
--     local clients = vim.lsp.get_active_clients()
--
--     if #clients > 0 then
--         vim.lsp.buf.rename()
--     else
--         local word = vim.fn.expand('<cword>')
--         word = vim.fn.escape(word, "/")
--         if not word or word == "" then return print("Error: no word selected") end
--
--         if #word == 1 or word == " " then return print("Error: selection too small (1 char)") end
--
--         local replace_with = vim.fn.input(word .. " -> ")
--
--         if not replace_with then return print("Error: replace-with is nil") end
--
--         if #replace_with == 1 or replace_with == "" or replace_with == " " then return print("Cancelled: replacement too small") end
--
--         local extra_flags = ""
--
--         if string.find(replace_with," !!g") then
--             replace_with = string.gsub(replace_with," !!g","")
--             extra_flags = extra_flags .. "g"
--         end
--
--         if string.find(replace_with," !!c") then
--             replace_with = string.gsub(replace_with," !!c","")
--             extra_flags = extra_flags .. "c"
--         end
--
--         vim.cmd(string.format("silent vimgrep /%s/ `find . -type f`",word))
--         vim.cmd(string.format("cdo :s/%s/%s/"..extra_flags,word,replace_with))
--     end
-- end, { desc = 'Refactor rename' })
--
vim.keymap.set('n', '<Space>r.', ":lua vim.lsp.buf.code_action()<cr>", {
    desc = 'Refactor code action',
})

return M
