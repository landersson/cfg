require("config.lazy")

vim.keymap.set("i", "jk", "<Esc>", { remap = true })
vim.keymap.set({ "n", "v" }, "<leader>c", "gc", { remap = true })
vim.keymap.set({ "n" }, "<leader>cc", "gcc", { remap = true })

-- Save file shortcut
vim.keymap.set({ "n" }, "<leader>w", ":w!<cr>", { remap = true })

-- Edit file in the same directory
vim.keymap.set('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>', {})
vim.keymap.set('n', '<leader>X', ':x<cr>', {})
vim.keymap.set('n', '<leader>j', ':e #<cr>', {})
vim.keymap.set('n', '<leader>z', ':b#<cr>', {})

vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.matchpairs:append("<:>")

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
