return {
  "olimorris/codecompanion.nvim",
  enabled = false,
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
