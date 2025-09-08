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
}
