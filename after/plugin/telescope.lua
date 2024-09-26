local telescope = require("telescope")
telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules"
        }
    }
})

local builtin = require('telescope.builtin')

-- Find files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Find git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Find using grep in current buffer
vim.keymap.set({'n', 'v'}, '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep()
end)
