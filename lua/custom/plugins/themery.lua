return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    local available_colorschemes = vim.fn.getcompletion('', 'color')
    local colorschemes = {}
    for _, colorscheme in ipairs(available_colorschemes) do
      table.insert(colorschemes, colorscheme)
    end

    require('themery').setup {
      themes = colorschemes,
    }
  end,
}
