return {
  'olimorris/codecompanion.nvim',
  enabled = true,
  event = 'VeryLazy',
  cmd = 'CodeCompanion',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.diff',
  },
  opts = {
    display = {
      chat = {
        window = {
          opts = {
            number = false,
          },
        },
      },
      diff = {
        provider = 'mini_diff',
      },
    },
    adapters = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'gpt-4.1',
            },
          },
        })
      end,
    },
  },
  keys = {
    {
      '<leader>ca',
      '<cmd>CodeCompanionActions<cr>',
      mode = { 'n', 'v' },
      noremap = true,
      silent = true,
    },
    {
      '<leader>cc',
      '<cmd>CodeCompanionChat Toggle<cr>',
      mode = { 'n', 'v' },
      noremap = true,
      silent = true,
    },
    {
      '<leader>cs',
      ':CodeCompanion ',
      mode = { 'n', 'v' },
      desc = 'CodeCompanion Send',
      noremap = true,
    },
    {
      'ga',
      '<cmd>CodeCompanionChat Add<cr>',
      mode = { 'v' },
      noremap = true,
      silent = true,
    },
  },
  init = function()
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
