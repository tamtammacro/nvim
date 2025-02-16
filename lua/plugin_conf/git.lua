local notify = nil

function isDiffviewOpen()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("^diffview://") then return true end
    end
end

function isGitRepo()
    local handle = nil
    local osType = os.getenv("OS")

    if osType == "Windows_NT" then
        handle = io.popen('git rev-parse --is-inside-work-tree 2>nul')
    else
        handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
    end

    if not handle then return false end

    local result = handle:read('*a')
    handle:close()
    return result:match('true') ~= nil
end

function toggleGitDiffview()
    if isDiffviewOpen() then
        vim.cmd.DiffviewClose() 
    elseif not isDiffviewOpen() then
        if isGitRepo() then
            vim.cmd.DiffviewOpen()
        else
            if not notify then
                notify = require "notify"
            end

            if not notify then return end

            notify("This workspace does not have a git repo","error")
        end
    end
end

vim.keymap.set('n', '<M-g>', toggleGitDiffview, { desc = 'Git toggle diff view' })
