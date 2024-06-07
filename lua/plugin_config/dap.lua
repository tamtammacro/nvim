local dap, dapui
local ok

ok, dap = pcall(require, "dap")

if not ok then return print "dap is not installed" end

ok, dapui = pcall(require, "dapui")

if not ok then return print "dapui is not installed" end

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

require("mason-nvim-dap").setup({
    ensure_installed = { 'cpptools', "python" }
})


vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
dap.set_log_level('TRACE')

if true then return end

dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
            return "python_exe path"
        end,
        runInTerminal = false,
    },
}
