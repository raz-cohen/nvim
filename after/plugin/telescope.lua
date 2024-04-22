local builtin = require('telescope.builtin')

-- Find files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Find git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Find using grep in current buffer
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })

end)
