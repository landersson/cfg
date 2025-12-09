return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("diffview").setup({
      use_icons = false, -- Requires nvim-web-devicons
      view = {
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          -- disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
      },
    })
    --   local colors = M.get_colors()
    --
    --   return {
    --     -- FilePanelTitle = { fg = M.get_fg("Label") or colors.blue, style = "bold" },
    --     -- FilePanelCounter = { fg = M.get_fg("Identifier") or colors.purple, style = "bold" },
    --     FilePanelTitle = { fg = M.get_fg("Label") or colors.blue },
    --     FilePanelCounter = { fg = M.get_fg("Identifier") or colors.purple },
    --     FilePanelFileName = { fg = M.get_fg("Normal") or colors.white },
    --     Dim1 = { fg = M.get_fg("Comment") or colors.white },
    --     Primary = { fg = M.get_fg("Function") or "Purple" },
    --     Secondary = { fg = M.get_fg("String") or "Orange" },
    --   }
    -- end
    local hl = require("diffview.hl")
    hl.get_hl_groups_org = hl.get_hl_groups
    local f = function()
      local hl_groups = hl.get_hl_groups_org()
      hl_groups["FilePanelTitle"]["style"] = nil
      hl_groups["FilePanelCounter"]["style"] = nil
      return hl_groups
    end
    hl.get_hl_groups = f
  end
}
