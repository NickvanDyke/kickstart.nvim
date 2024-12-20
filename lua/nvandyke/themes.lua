return {
  {
    'rose-pine/neovim',
    lazy = true,
    priority = 1000,
    init = function()
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
  },
  { 'folke/tokyonight.nvim', lazy = true },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    config = function()
      require('gruvbox').setup {
        overrides = {
          -- https://github.com/ellisonleao/gruvbox.nvim/issues/304
          NormalFloat = { bg = '#32302f' },
          GitSignsAdd = { link = 'GruvboxGreenSign' },
          GitSignsChange = { link = 'GruvboxOrangeSign' },
          GitSignsDelete = { link = 'GruvboxRedSign' },
        },
      }
    end,
  },
  { 'projekt0n/github-nvim-theme', lazy = true },
  { 'catppuccin/nvim', lazy = true },
}
