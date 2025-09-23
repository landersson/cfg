return {
  {
    -- `lazydev` configures lua lsp for your neovim config, runtime and plugins
    -- used for completion, annotations and signatures of neovim apis
    'folke/lazydev.nvim',
    enabled = true,
    ft = 'lua',
    opts = {
      library = {
        -- load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "bashls",
          "ruff",
          "taplo",
        },
        automatic_enable = false, --disable
      })
    end
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { 'shfmt' }
      })
    end
  },


  {
    "neovim/nvim-lspconfig",
    config = function()
      -- local lspconfig = vim.lsp.config()
      --
      -- lspconfig.lua_ls.setup({
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         disable = { 'missing-fields' },
      --         globals = { 'vim' }
      --       }
      --     },
      --   },
      -- })
      -- lspconfig.clangd.setup({})
      -- lspconfig.bashls.setup({})
      -- lspconfig.taplo.setup({})
      -- lspconfig.ruff.setup({
      --   init_options = {
      --     settings = {
      --       -- lineLength = 100,
      --       -- logLevel = "debug",
      --       -- logFile = "/tmp/ruff.log",
      --       configurationPreference = "filesystemFirst"
      --     }
      --   }
      -- })

      vim.lsp.config('clangd', {})
      vim.lsp.enable({ 'bashls', 'taplo', 'ruff', 'clangd', 'lua_ls' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  }
}
