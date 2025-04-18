return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    -- Add installed executables to PATH
    require('mason').setup()

    -- Extend lspconfig defaults
    vim.lsp.config('harper_ls', {
      filetypes = { 'markdown' },
    })
    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/circleciconfig.json'] = '/.circleci/config.yml',
          },
        },
      },
    })

    vim.lsp.enable {
      'lua_ls',
      'graphql',
      'terraformls',
      'intelephense',
      'cssls',
      'volar',
      'basedpyright',
      'yamlls',
      'circleci',
      'harper_ls',
    }
  end,
}
