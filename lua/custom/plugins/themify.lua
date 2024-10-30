return {
  'lmantw/themify.nvim',

  lazy = false,
  priority = 999,

  config = function()
    require('themify').setup {
      -- 'Tsuzat/NeoSolarized.nvim',
      'folke/tokyonight.nvim',
      {
        'ellisonleao/gruvbox.nvim',
        before = function()
          require('gruvbox').setup {
            overrides = {
              SignColumn = { bg = 'none' },
            },
          }
        end,
      },
      'projekt0n/github-nvim-theme',
      'catppuccin/nvim',
      'default',
    }

    vim.keymap.set('n', '<leader>tt', '<cmd>Themify<CR>', { desc = '[T]oggle [T]heme' })
  end,
}
