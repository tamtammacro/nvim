local options = require "user.options"

if not options.want_default_keybinds then return end

local keymaps = require "user.keymaps"
local utils = require "user.util_functions"

local function mrn(mode)
    return mode or "n"
end

local function set_keymap(mode,obj,func,args)
    xpcall(function()
        vim.keymap.set(mode,obj.key,func,obj.opts or args)
    end,function(error)
        require "notify"(("Error while trying to set keymap: %s"):format(error))
    end)
end

local _ = require("telescope.builtin")

local success,err = pcall(function()
    if options.want_telescope then
        set_keymap(mrn(),keymaps.telescope.live_grep,_.live_grep)
        set_keymap(mrn(),keymaps.telescope.find_files,_.find_files)
    end

    if options.file_explorer.enabled then
        if options.file_explorer.name == "netrw" then
            set_keymap(mrn(),keymaps.file_explorer.toggle,vim.cmd.Ex)
        else
            set_keymap(mrn(),keymaps.file_explorer.toggle,vim.cmd.Oil)
        end
    end

    if options.want_git_intigration then
        set_keymap(mrn(),keymaps.git.git_window,function()
            vim.cmd.Git()
        end)
    end

    if options["nvim-tree"].enabled then
        set_keymap(mrn(),keymaps.nvim_tree.toggle,vim.cmd.NvimTreeToggle)
    end

    if options.want_treesj then
        set_keymap(mrn(), keymaps.treesj.toggle, require('treesj').toggle)
        set_keymap(mrn(),keymaps.treesj.toggle_split, function()
            require('treesj').toggle({ split = { recursive = true } })
        end)
    end

    if options.want_my_user_commands then
        set_keymap(mrn(),keymaps.my_commands.buf_cap_word,utils.buf_cap_word)
    end

    if options.want_builtin_terminal then
        set_keymap(mrn(),keymaps.terminal.toggle,vim.cmd.ToggleTerm)
        require "core.term"
    end

    if options.lsp_trouble.enabled then
        local trouble = require "trouble"
        local keys = keymaps.lsp_trouble

        local trouble_telescope = require("trouble.providers.telescope")
        local telescope = require("telescope")

        telescope.setup {
          defaults = {
            mappings = {
              i = { ["<c-t>"] = trouble_telescope.open_with_trouble },
              n = { ["<c-t>"] = trouble_telescope.open_with_trouble },
            },
          },
        }

        set_keymap(mrn(), keys.workspace_diagnostics, function() trouble.open("workspace_diagnostics") end)
        set_keymap(mrn(), keys.document_diagnostics, function() trouble.open("document_diagnostics") end)
        set_keymap(mrn(), keys.quick_fix, function() trouble.open("quickfix") end)
        set_keymap(mrn(), keys.locklist, function() trouble.open("loclist") end)
        set_keymap(mrn(), keys.lsp_reference, function() trouble.open("lsp_references") end)
        set_keymap(mrn(),keys.toggle,vim.cmd.TroubleToggle)
    end

    set_keymap(mrn(), keymaps.goto.goto_preview, "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
end)

if not success and err then
    local starting_index = select(2,err:find("field"))
    if not starting_index then return --[[ print "Failed to get error index"  ]]end
    local invalid_keybind_name = err:sub(starting_index+1,#err)
    require("notify")(("Failed to set keybind:%s"):format(invalid_keybind_name))
end
