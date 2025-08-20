return {
  'akinsho/toggleterm.nvim',
  version = "*", -- or specify a commit/version
  config = function()
    require('toggleterm').setup {
      size = 20,
      open_mapping = [[<c-\>]], -- Sets Ctrl-\ as the toggle key
      -- open_mapping = [[<leader>t]], -- Sets Ctrl-\ as the toggle key
      shell = "bash"
    }

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
