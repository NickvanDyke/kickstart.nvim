return {
  "Tsuzat/NeoSolarized.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd [[ colorscheme NeoSolarized ]]
    end
}
