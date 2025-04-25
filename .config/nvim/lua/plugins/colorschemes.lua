return {
  {
    "shaunsingh/nord.nvim",
    priority = 10,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
      vim.cmd.colorscheme('nord')
    end
  },
  {
    "oahlen/iceberg.nvim",
    name = "iceberg",
    config = function()
      -- vim.cmd.colorscheme('iceberg')
    end
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 100,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = false
      vim.g.everforest_background = 'hard'
      vim.cmd.colorscheme('everforest')
    end
  },
  -- { "EdenEast/nightfox.nvim" }, -- lazy
  -- { "catppuccin/nvim", name = "catppuccin" },
  --     {
  --   "thesimonho/kanagawa-paper.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --     "mcauley-penney/ice-cave.nvim",
  --     config = function()
  --         vim.cmd.colorscheme("ice-cave")
  --     end,
  --     priority = 1000
  -- }
  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup({
  --       -- ...
  --     })
  --
  --     vim.cmd('colorscheme github_dark')
  --   end,
  --
  --   }
}
