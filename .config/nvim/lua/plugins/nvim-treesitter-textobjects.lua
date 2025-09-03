return {
  "nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["a,"] = "@parameter.outer",
            ["i,"] = "@parameter.inner",
            ["ac"] = "@class.outer",
          },
        },
      },
    }
  end
}
