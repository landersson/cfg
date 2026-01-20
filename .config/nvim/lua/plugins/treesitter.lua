return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- dependencies = {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  -- },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "c", "cpp", "json", "lua", "python", "vim", "vimdoc", "javascript", "html", "yaml" },
    })
    vim.treesitter.language.register("bash", "zsh")
  end
}
