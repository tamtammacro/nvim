local options = require "user.options"

local keymaps = require "user.keymaps"
local utils = require "user.myfunctions"

local function set_keymap(obj,func,args)
    xpcall(function()
        vim.keymap.set((obj.mode or "n"),obj.key,func,obj.opts or args)
    end,function(error)
        require "notify"(("Error while trying to set keymap: %s"):format(error))
    end)
end

local success,err = pcall(function()
    if options.telescope.enabled then
        local builtin = require("telescope.builtin")
        set_keymap(keymaps.telescope.live_grep,builtin.live_grep)
        set_keymap(keymaps.telescope.find_files,builtin.find_files)
    end

    if options.file_explorer.enabled then
        if options.file_explorer.path == "netrw" then
            set_keymap(keymaps.file_explorer.toggle,vim.cmd.Ex)
        else
            set_keymap(keymaps.file_explorer.toggle,vim.cmd.Oil)
        end
    end

    if options.git.enabled then
        set_keymap(keymaps.git.git_window,function()
            vim.cmd.Git()
        end)
    end

    if options["nvim-tree"].enabled then
        set_keymap(keymaps.nvim_tree.toggle,vim.cmd.NvimTreeToggle)
    end

    if options.treesj.enabled then
        local treesj = require "treesj"
        local opts = { split = { recursive = true } }

        set_keymap(keymaps.treesj.toggle,treesj.toggle)
        set_keymap(keymaps.treesj.toggle_split, function()
            treesj.toggle(opts)
        end)
    end

    if options.want_my_user_commands then
        set_keymap(keymaps.my_commands.buf_cap_word,utils.buf_cap_word)
    end

    if options.terminal.enabled then
        set_keymap(keymaps.terminal.toggle,vim.cmd.ToggleTerm)
    end

    if options.lsp_trouble.enabled then
        local trouble = require "trouble"
        local keys = keymaps.lsp_trouble

        set_keymap(keys.workspace_diagnostics, function() trouble.open("workspace_diagnostics") end)
        set_keymap(keys.document_diagnostics, function() trouble.open("document_diagnostics") end)
        set_keymap(keys.quick_fix, function() trouble.open("quickfix") end)
        set_keymap(keys.locklist, function() trouble.open("loclist") end)
        set_keymap(keys.lsp_reference, function() trouble.open("lsp_references") end)
        set_keymap(keys.toggle,vim.cmd.TroubleToggle)
    end

    set_keymap(keymaps.goto.goto_preview, "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})

    if options.symbols_outline.enabled then
        set_keymap(keymaps.symbols.toggle,vim.cmd.SymbolsOutline)
    end
end)

if not success and err then
    local starting_index = select(2,err:find("field"))
    if not starting_index then return end
    local invalid_keybind_name = err:sub(starting_index+1,#err)
    require("notify")(("Failed to set keybind:%s"):format(invalid_keybind_name))
end
