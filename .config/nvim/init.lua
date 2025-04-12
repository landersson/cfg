require("config.lazy")

-- vim.g.mapleader = ","

vim.keymap.set("i", "jk", "<Esc>", {remap = true})
vim.keymap.set({"n", "v"}, "<leader>c", "gc", {remap = true})
vim.keymap.set({"n"}, "<leader>cc", "gcc", {remap = true}) 


vim.keymap.set({"n"}, "<leader>w", ":w!<cr>", {remap = true})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

-- <leader> = maploader = spacebar, so it's <spacebar>-fg
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
