return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'meuter/lualine-so-fancy.nvim',
    'AndreM222/copilot-lualine',
  },
  config = function()
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    require('lualine').setup {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      tabline = {
        lualine_z = {
          'tabs',
          {
            -- https://github.com/nvim-lualine/lualine.nvim/discussions/845#discussioncomment-4984116
            function()
              if vim.o.showtabline ~= 1 then -- If we don't check, then repeatedly setting will cause redraw and cursor flicker
                vim.o.showtabline = 1
              end
              return nil
            end,
          },
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return string.sub(str, 0, 1)
            end,
          },
        },
        lualine_b = {
          {
            function()
              ---@diagnostic disable-next-line: undefined-field
              return vim.fn.fnamemodify(vim.loop.cwd(), ':t')
            end,
            icon = '', -- Same as my powerline prompt
          },
          {
            -- 'b:gitsigns_head', -- NOTE: based on open file I think. Thus disappears when e.g. lazygit is focused
            'branch',
            icon = '',
            fmt = function(str)
              if string.len(str) > 11 then
                return string.sub(str, 1, 11) .. '…'
              else
                return str
              end
            end,
          },
          {
            'diff',
            source = diff_source,
            cond = function()
              return false
            end,
          },
          'diagnostics',
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            fmt = function(str)
              local parts = vim.split(str, '/')
              local filename = '%#Bold#' .. parts[#parts] .. '%*'
              if #parts == 1 then
                return filename
              else
                local path = '%#Comment#' .. table.concat(parts, '/', 1, #parts - 1) .. '/' .. '%*'
                return path .. filename
              end
            end,
            separator = '',
          },
          { 'filetype', icon_only = true, padding = 0, separator = '' },
          {
            'windows',
            cond = function()
              return false
            end,
            show_modified_status = false,
            filetype_names = {
              ['snacks_dashboard'] = 'Dashboard',
            },
            fmt = function(str, ctx)
              local filename = str
              local filename_to_show = filename:match '^index%..+$'
                  -- prefix parent dir
                  and vim.fn.fnamemodify(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.bufnr), ':h'), ':t') .. '/' .. filename
                or filename

              -- Takes a long time to load and we'll never need on the Dashboard
              local arrow_icon = package.loaded['arrow'] and require('arrow.statusline').text_for_statusline_with_icons(ctx.bufnr) or nil
              return arrow_icon and (filename_to_show .. ' ' .. arrow_icon) or filename_to_show
            end,
          },
        },
        lualine_x = {},
        lualine_y = {
          'fancy_macro',
          'fancy_searchcount',
          {
            'copilot',
            symbols = {
              -- The idle symbol has a right-space but the spinners don't
              spinners = { '⠋ ', '⠙ ', '⠹ ', '⠸ ', '⠼ ', '⠴ ', '⠦ ', '⠧ ', '⠇ ', '⠏ ' },
            },
          },
        },
      },
    }

    -- Awkward to create hl group at the right time
    vim.api.nvim_create_autocmd('BufReadPre', {
      callback = function()
        vim.api.nvim_set_hl(0, 'Bold', { bold = true })
      end,
    })
  end,
}
