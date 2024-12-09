return {
  'b0o/incline.nvim',
  config = function()
    -- TODO: delayed appearance on first open.
    -- Not critical rn because `hide.only_win = true`
    local helpers = require 'incline.helpers'
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      hide = {
        only_win = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        return {
          { '', guifg = ft_color },
          ft_icon and { ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
          { ' ' .. filename .. ' ', gui = modified and 'bold,italic' or 'bold', guibg = '#44406e' },
        }
      end,
    }
  end,
  event = 'VeryLazy',
}