return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      }
    },
    diff = {
      provider = "mini_diff",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

}
