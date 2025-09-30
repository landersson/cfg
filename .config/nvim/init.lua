require("config.lazy")

vim.keymap.set("i", "jk", "<Esc>", { remap = true })

-- Toggle comment status for entire selection
vim.keymap.set({ "n" }, "<leader>cc", "gcc", { remap = true })
vim.keymap.set({ "v" }, "<leader>cc", "gc", { remap = true })

-- Invert comment status individually for all lines in selection
vim.keymap.set({ "n", "v" }, "<leader>ci", ":normal gcc<cr>", { remap = true })

-- Write file
vim.keymap.set({ "n" }, "<leader>w", ":w!<cr>", { remap = true })

-- Edit file in the same directory
vim.keymap.set('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>', {})
vim.keymap.set('n', '<leader>X', ':x<cr>', {})
vim.keymap.set('n', '<leader>z', ':b#<cr>', {})
vim.keymap.set('n', '<leader>q', ':bp|bd #<cr>', {})
vim.keymap.set('n', '<leader>.', ':tabclose<cr>', { remap = true })
vim.keymap.set('n', '<leader>v', ':DiffviewOpen -uno<cr>', {})
vim.keymap.set('n', '<leader>l', ':Lazy<cr>', {})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Show most severe issue in gutter
vim.diagnostic.config({
  severity_sort = true,
})

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

-- Clear search pattern highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamed'
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

-- Run Telescope live-grep on word under cursor
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

-- Hack to reload in-tree substrata color theme... for theme dev
vim.keymap.set('n', '<leader><space>', function()
  local word = vim.fn.expand('<cword>')
  package.loaded['themes.substrata.colors'] = nil
  package.loaded['themes.substrata.config'] = nil
  package.loaded['themes.substrata'] = nil
  require('themes.substrata').colorscheme()
  print(word)
end, { desc = 'Reload colorscheme' })

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
  -- MacOS-specific config here
  vim.o.shell = "/opt/homebrew/bin/bash"
end


-- Neovide configuration
if vim.g.neovide then
  -- Disable all animations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00

  if vim.fn.has("mac") == 1 then
    vim.o.guifont = "Menlo:h18"
  end
end
