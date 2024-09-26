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
        preLaunchTask = function()
            local solution_path = vim.fn.input('Path to solution: ', vim.fn.getcwd() .. '/', 'file')
            vim.cmd('!dotnet build ' .. solution_path)
        end,
    },
    {
        type = "coreclr",
        name = "attach - netcoredbg",
        request = "attach",
        processId = require('dap.utils').pick_process,
        sourceFileMap = {
            ['/path/to/your/source'] = '${workspaceFolder}/path/to/your/source'
        },
    },
}

-- Enable logging for debugging
dap.set_log_level('DEBUG')
