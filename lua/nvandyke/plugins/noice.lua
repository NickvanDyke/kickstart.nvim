return {
  'folke/noice.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    --   The default are super intrusive and laggy so, disabled for now
    -- 'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
      documentation = {
        opts = {
          win_options = {
            winblend = vim.g.winblend_default,
          },
        },
      },
      signature = {
        auto_open = {
          -- blink.cmp handles this better
          enabled = false,
        },
      },
    },
    messages = {
      view_search = false,
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      -- command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  keys = {
    {
      '<leader>n',
      '<cmd>Noice<CR>',
      desc = 'Noice',
      mode = 'n',
    },
  },
}
