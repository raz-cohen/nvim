local emmet = require("nvim-emmet")

vim.keymap.set({ "n", "v" }, '<leader>xe', emmet.wrap_with_abbreviation)
