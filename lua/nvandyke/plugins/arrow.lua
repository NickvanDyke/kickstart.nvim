return {
  'otavioschwanck/arrow.nvim',
  keys = {
    '\'',
    'm',
  },
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    leader_key = '\'', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
    separate_by_branch = true,
    save_key = 'git_root',
    window = {
      border = vim.g.border_default,
    },
    mappings = {
      open_vertical = '<C-v>',
      open_horizontal = '<C-s>',
    },
  },
}
