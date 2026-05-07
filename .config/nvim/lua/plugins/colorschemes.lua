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
      --vim.cmd.colorscheme('nord')
    end
  },
  {
    "oahlen/iceberg.nvim",
    priority = 1,
    name = "iceberg",
    config = function()
      vim.cmd.colorscheme('iceberg')
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
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  { 'slugbyte/lackluster.nvim' },
  { "miikanissi/modus-themes.nvim", priority = 1000 },
  { "xero/miasma.nvim" },
  { "saeeedhany/parchment.nvim" },
}
