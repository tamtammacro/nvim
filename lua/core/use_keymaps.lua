local options = require "core.options"

if not options.want_default_keybinds then return end

local keybinds = require "user.keymaps"

local function mrn(mode)
    return mode or "n"
end

local set_keymap = vim.keymap.set

vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
set_keymap(mrn(),"<ESC><ESC><ESC>",vim.cmd.noh)

local utils = require "user.util_functions"
local _ = require("telescope.builtin")

local success,err = pcall(function()
    if options.want_telescope then
        set_keymap(mrn(),keybinds.telescope.live_grep.key,_.live_grep)
        set_keymap(mrn(),keybinds.telescope.find_files.key,_.find_files)
    end

    if options.file_explorer.enabled then
        if options.file_explorer.name == "netrw" then
            set_keymap(mrn(),keybinds.file_explorer.toggle.key,vim.cmd.Ex)
        else
            set_keymap(mrn(),keybinds.file_explorer.toggle.key,vim.cmd.Oil)
        end
    end

    if options.want_git_intigration then
        set_keymap(mrn(),keybinds.git.git_window.key,function()
            vim.cmd.Git()
            --vim.cmd.only()
        end)
    end

    if options["nvim-tree"].enabled then
        vim.keymap.set(mrn(),keybinds.nvim_tree.toggle.key,vim.cmd.NvimTreeToggle)
    end

    if options.want_treesj then
        set_keymap(mrn(), keybinds.treesj.toggle.key, require('treesj').toggle)
        set_keymap(mrn(),keybinds.treesj.toggle_split.key, function()
            require('treesj').toggle({ split = { recursive = true } })
        end)
    end

    if options.want_my_user_commands then
        set_keymap(mrn(keybinds.my_commands.buf_cap_word.mode),keybinds.my_commands.buf_cap_word.key,utils.buf_cap_word)
    end

    if options.want_builtin_terminal then
        set_keymap(mrn(),keybinds.terminal.toggle.key,vim.cmd.ToggleTerm)
        require "user.term"
    end

    if options.lsp_trouble.enabled then
        local trouble = require "trouble"

        local keys = keybinds.lsp_trouble

        --set_keymap(mrn(), keys.open.key, function() trouble.open() end)
        set_keymap(mrn(), keys.workspace_diagnostics.key, function() trouble.open("workspace_diagnostics") end)
        set_keymap(mrn(), keys.document_diagnostics.key, function() trouble.open("document_diagnostics") end)
        set_keymap(mrn(), keys.quick_fix.key, function() trouble.open("quickfix") end)
        set_keymap(mrn(), keys.locklist.key, function() trouble.open("loclist") end)
        set_keymap(mrn(), keys.lsp_reference.key, function() trouble.open("lsp_references") end)
        set_keymap(mrn(),keys.toggle.key,vim.cmd.TroubleToggle)
    end

    vim.keymap.set(mrn(), keybinds.goto.goto_preview.key, "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
end)

if not success and err then
    local starting_index = select(2,err:find("field"))
    if not starting_index then return print "Failed to get error index" end
    local invalid_keybind_name = err:sub(starting_index+1,#err)
    require("notify")(("Failed to set keybind:%s"):format(invalid_keybind_name))
end
