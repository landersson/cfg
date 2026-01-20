return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- No setup call needed; just define keymaps using the textobjects API
    local select = require("nvim-treesitter.textobjects.select")

    local keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["a,"] = "@parameter.outer",
      ["i,"] = "@parameter.inner",
      ["ac"] = "@class.outer",
    }

    for keymap, query in pairs(keymaps) do
      vim.keymap.set({ "x", "o" }, keymap, function()
        select.select_textobject(query, "textobjects")
      end)
    end
  end
}
