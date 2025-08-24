require("config.lazy")

vim.keymap.set("i", "jk", "<Esc>", { remap = true })
vim.keymap.set({ "n", "v" }, "<leader>c", "gc", { remap = true })
vim.keymap.set({ "n" }, "<leader>cc", "gcc", { remap = true })

-- Save file shortcut
vim.keymap.set({ "n" }, "<leader>w", ":w!<cr>", { remap = true })

-- Edit file in the same directory
vim.keymap.set('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>', {})
vim.keymap.set('n', '<leader>X', ':x<cr>', {})
vim.keymap.set('n', '<leader>z', ':b#<cr>', {})
vim.keymap.set('n', '<leader>q', ':bp|bd #<cr>', {})
vim.keymap.set('n', '<leader>.', ':tabclose<cr>', {})
vim.keymap.set('n', '<leader>v', ':DiffviewOpen -uno<cr>', {})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Stop the sign gutter from opening/closing
-- vim.opt.signcolumn = "yes"
vim.opt.signcolumn = "number" -- show gutter signs in number columns

vim.opt.matchpairs:append("<:>")

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

vim.keymap.set('n', '<leader>a', function()
  local word = vim.fn.expand('<cword>')
  if word == '' then
    require('telescope.builtin').live_grep()
  else
    require('telescope.builtin').live_grep({
      default_text = '\\b' .. word .. '\\b'
    })
  end
end, { desc = 'Live grep word under cursor (whole word)' })

-- Autocommand to format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
  callback = function(args)
    -- Only format if an LSP client is attached to the buffer
    if #vim.lsp.get_clients() > 0 then
      vim.lsp.buf.format({ async = false }) -- Set async = false for synchronous formatting
    end
  end,
})

if vim.fn.has("mac") == 1 then
  -- Your macOS-specific Neovim commands here
  vim.o.shell = "/opt/homebrew/bin/bash"
end
