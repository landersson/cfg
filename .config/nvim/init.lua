require("config.lazy")

vim.keymap.set("i", "jk", "<Esc>", {remap = true})
vim.keymap.set({"n", "v"}, "<leader>c", "gc", {remap = true})
vim.keymap.set({"n"}, "<leader>cc", "gcc", {remap = true}) 


vim.keymap.set({"n"}, "<leader>w", ":w!<cr>", {remap = true})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>m', builtin.buffers, {})
