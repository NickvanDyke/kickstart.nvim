return {
  'saghen/blink.cmp',
  -- enabled = false, -- NOTE: if it crashes after updating, re-install; https://github.com/Saghen/blink.cmp/issues/68
  lazy = false, -- lazy loading handled internally
  version = 'v0.*',
  opts = {
    keymap = {
      preset = 'enter',
      -- ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },
    sources = {
      providers = {
        snippets = {
          enabled = false,
        },
        lsp = {
          min_keyword_length = 3,
          -- TODO: doesn't work, always falls back to buffer...???
          -- And that ignores buffer's min_keyword_length.
          -- So I set it above too.
          fallbacks = {},
        },
        buffer = {
          -- Otherwise it shows up immediately which is super annoying
          min_keyword_length = 3,
          score_offset = -3,
        },
      },
    },
    completion = {
      menu = {
        border = 'none', -- anything else looks bad
        winblend = vim.g.winblend_default,
      },
      documentation = {
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = vim.g.border_default,
          winblend = vim.g.winblend_default,
        },
      },
      signature = {
        window = {
          border = vim.g.border_default,
          winblend = vim.g.winblend_default,
          treesitter_highlighting = true,
        },
      },
    },
  },
}
