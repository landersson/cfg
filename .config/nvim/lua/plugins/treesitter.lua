return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- dependencies = {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  -- },
  config = function()
    local parsers = { "c", "cpp", "json", "lua", "python", "vim", "vimdoc", "javascript", "html", "yaml", "bash" }
    require("nvim-treesitter").install(parsers)
    vim.treesitter.language.register("bash", "zsh")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end
}
