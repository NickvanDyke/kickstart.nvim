return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    settings = {
      separate_diagnostic_server = false, -- Uses too much memory in Polco
      expose_as_code_action = 'all',
      jsx_close_tag = {
        enable = true,
        filetypes = { 'typescriptreact', 'javascriptreact' },
      },
      tsserver_format_options = {
        convertTabsToSpaces = false,
      },
    },
  },
}
