return {
  'oflisback/obsidian-bridge.nvim',
  enabled = false,
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  event = {
    -- `ft` causes it to load for floating windows, like LSP hover
    'BufReadPre *.md',
    'BufNewFile *.md',
  },
  opts = {
    -- TODO: no luck with https server thus far
    -- obsidian_server_address = 'https://127.0.0.1:27124/',
  },
}
