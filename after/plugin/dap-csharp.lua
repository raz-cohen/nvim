local dap = require('dap')

-- Set noshellslash for Windows
vim.cmd('set noshellslash')
dap.adapters.coreclr = {
    type = 'executable',
    command = os.getenv('USERPROFILE') .. '/scoop/apps/netcoredbg/current/netcoredbg.exe',
    args = { '--interpreter=vscode' }
}
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}
