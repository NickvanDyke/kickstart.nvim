return {
  'saghen/blink.cmp',
  version = 'v0.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'xzbdmw/colorful-menu.nvim',
  },
  opts = {
    keymap = {
      preset = 'default',
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      -- use_nvim_cmp_as_default = true,
    },
    sources = {
      per_filetype = {
        org = { 'orgmode' },
      },
      providers = {
        snippets = {
          enabled = false,
        },
        lsp = {},
        path = {},
        buffer = {
          -- min_keyword_length = 3,
          score_offset = -3,
        },
        -- orgmode = {
        --   name = 'Orgmode',
        --   module = 'orgmode.org.autocompletion.blink',
        --   fallbacks = { 'buffer' },
        -- },
      },
    },
    completion = {
      trigger = {
        -- show_on_insert_on_trigger_character = false,
      },
      menu = {
        border = 'none',
        winblend = vim.g.winblend_default,
        draw = {
          treesitter = { 'lsp' },
          columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'label_description' }, { 'source_name' } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = vim.g.border_default,
          winblend = vim.g.winblend_default,
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = vim.g.border_default,
        winblend = vim.g.winblend_default,
        treesitter_highlighting = true,
      },
    },
  },
}
