-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'slugbyte/lackluster.nvim',
    'uga-rosa/ccc.nvim',
    'brenoprata10/nvim-highlight-colors',
    {
      "echasnovski/mini.diff",
      opts = {
        view = {
          style = 'number',
        },
      },
    },

    -- Local, modified substrata theme
    {
      dir = vim.fn.stdpath("config") .. "/lua/themes/substrata",
      name = "substrata-local",
      lazy = false,
      priority = 1000,
      config = function()
        require("themes.substrata").colorscheme()
      end,
    },
    {
      "folke/snacks.nvim",
      opts = {
        terminal = {
          enabled = true,
          win = {
            position = "bottom",
            size = 0.3,
            float = {
              border = "single",
            },
          },
        }
      },
      config = function(_, opts)
        require("snacks").setup(opts)

        -- Set up keybindings
        vim.keymap.set("n", "<leader>t", function()
          require("snacks").terminal.toggle("/bin/bash", { position = "bottom", size = 0.3 })
        end, { desc = "Toggle Bottom Terminal" })

        vim.keymap.set("n", "<leader>T", function()
          require("snacks").terminal.toggle({ position = "float", size = 0.5 })
        end, { desc = "Toggle Floating Terminal" })

        vim.keymap.set("n", "<leader>g", function()
          require("snacks").terminal.toggle({ command = "lazygit", position = "float" })
        end, { desc = "Open LazyGit" })
      end,
    },
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "nord" } },

  -- automatically check for plugin updates
  checker = { enabled = true },
})
