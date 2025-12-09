vim.g.copilot_node_command = '.nvm/versions/node/v24.*/bin/node'
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',

    dependencies = 'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
    event = 'InsertEnter',                        -- after entering insert mode
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right | bottom |
            ratio = 0.4,
          },
        },

        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 50,
          trigger_on_accept = true,
          keymap = {
            accept = '<M-l>',
            -- accept = '<C-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          -- ['.'] = false,
        },
        nes = {
          enabled = false, -- requires copilot-lsp as a dependency
          auto_trigger = false,
          keymap = {
            accept_and_goto = '<leader>P',
            accept = false,
            dismiss = '<Esc>',
          },
        },
        logger = {
          file = vim.fn.stdpath 'log' .. '/copilot-lua.log',
          file_log_level = vim.log.levels.DEBUG,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = 'off', -- "off" | "messages" | "verbose"
          trace_lsp_progress = false,
          log_lsp_messages = false,
        },
        copilot_node_command = vim.fn.expand '~/.nvm/versions/node/v24.*/bin/node', -- Node.js version must be > 22.x
        workspace_folders = {},
        copilot_model = '',
        disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
        server = {
          type = 'nodejs',                     -- "nodejs" | "binary"
          custom_server_filepath = nil,
        },
        server_opts_overrides = {},
      }

      -- force re-enable as copilot doesn't seem to attach to buffers otherwise
      vim.schedule(function()
        vim.cmd 'Copilot disable'
        vim.cmd 'Copilot enable'
      end)
    end, -- copilot config fx
  },     -- copilot.lua
}
