return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '1.0.*',
  dependencies = {
    'xzbdmw/colorful-menu.nvim',
    'Kaiser-Yang/blink-cmp-avante',
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
      default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            -- options for blink-cmp-avante
          },
        },
        snippets = {
          enabled = false,
        },
        lsp = {},
        path = {},
        buffer = {
          -- min_keyword_length = 3,
          score_offset = -3,
        },
      },
      per_filetype = {
        codecompanion = { 'codecompanion' },
      },
    },
    completion = {
      trigger = {
        -- show_on_insert_on_trigger_character = false,
      },
      menu = {
        border = 'none',
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
      },
    },
    signature = {
      enabled = true,
      trigger = {
        enabled = true,
      },
      window = {
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
  },
}
