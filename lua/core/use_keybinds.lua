local options = require "core.options"

if not options.want_default_keybinds then return end

local keybinds = require "user.keybinds"

local function mrn(mode)
    return mode or "n"
end

local function set_keymap(mode,key,callback)
    vim.keymap.set(mode,key,callback)
end

vim.api.nvim_set_keymap("i","jk","<ESC>",{noremap = true})
set_keymap(mrn(),"<ESC><ESC><ESC>",vim.cmd.noh)

local utils = require "user.util_functions"
local _ = require("telescope.builtin")

local success,err = pcall(function()
    if options.want_telescope then
        set_keymap(mrn(),keybinds.telescope.live_grep.key,_.live_grep)
        set_keymap(mrn(),keybinds.telescope.find_files.key,_.find_files)
    end

    set_keymap(mrn(),keybinds.file_manager.netrw.key,vim.cmd.Ex)

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
end)

if not success and err then
    local starting_index = select(2,err:find("field"))
    if not starting_index then return print "Failed to get error index" end
    local invalid_keybind_name = err:sub(starting_index+1,#err)
    require("notify")(("Failed to set keybind:%s"):format(invalid_keybind_name))
end
