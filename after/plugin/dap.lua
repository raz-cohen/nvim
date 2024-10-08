local dap = require('dap')

vim.keymap.set('n', '<F5>', function() dap.continue() end, { noremap = true })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { noremap = true })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { noremap = true })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { noremap = true })
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { noremap = true })
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { noremap = true })
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { noremap = true })
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { noremap = true })
vim.keymap.set('n', '<leader>dl', function() dap.ran_last() end, { noremap = true })
