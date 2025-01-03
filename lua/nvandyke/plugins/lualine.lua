return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
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
              return ''
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
            'b:gitsigns_head', -- NOTE: based on open file I think. Thus disappears when e.g. lazygit is focused
            icon = '',
            fmt = function(str)
              -- 8 is just enough to show the Jira ticket
              if string.len(str) > 8 and vim.o.columns <= 100 then
                return string.sub(str, 1, 8) .. '…'
              else
                return str
              end
            end,
          },
          {
            'diff',
            source = diff_source,
            -- cond = function()
            --   return false
            -- end,
          },
          'diagnostics',
        },
        lualine_c = {},
        lualine_x = {
          {
            'filename',
            path = 1,
            fmt = function(str, ctx)
              local parts = vim.split(str, '/')
              -- TODO: bg is wrong in themes that change it
              local filename = '%#LualineFilename#' .. parts[#parts] .. '%*'

              -- local filename_to_show = filename:match '^index%..+$'
              --     -- prefix parent dir
              --     and vim.fn.fnamemodify(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.bufnr), ':h'), ':t') .. '/' .. filename
              --   or filename
              -- local gitsigns = vim.b.gitsigns_status_dict
              -- if gitsigns and gitsigns.changed > 0 then
              --   filename = '%#GitSignsChange#' .. filename .. '%*'
              -- end
              if #parts == 1 then
                return filename
              else
                local path = '%#LualineFilepath#' .. table.concat(parts, '/', 1, #parts - 1) .. '/' .. '%*'
                return path .. filename
              end
            end,
            separator = '',
          },
          { 'filetype', icon_only = true, padding = 0, separator = '' },
          {
            function(ctx)
              return require('arrow.statusline').text_for_statusline_with_icons(ctx.bufnr)
            end,
            cond = function()
              return false
              -- Takes a long time to load and we'll never need on the Dashboard
              -- TODO: doesn't work. Maybe lualine doesn't allow this with function component
              -- return package.loaded['arrow']
            end,
          },
        },
        lualine_y = {
          {
            require('noice').api.statusline.mode.get,
            cond = require('noice').api.statusline.mode.has,
            fmt = function(str)
              return '󰑋 ' .. string.sub(str, #str)
            end,
            color = { fg = '#ff0000' },
          },
        },
      },
    }

    -- Awkward to create hl group at the right time
    vim.api.nvim_create_autocmd('UIEnter', {
      callback = function()
        local lualine_hl = vim.api.nvim_get_hl_by_name('lualine_c_normal', true)
        local comment_hl = vim.api.nvim_get_hl_by_name('Comment', true)
        vim.api.nvim_set_hl(0, 'LualineFilepath', { italic = true, fg = comment_hl.foreground, bg = lualine_hl.background })
        vim.api.nvim_set_hl(0, 'LualineFilename', { bold = true, bg = lualine_hl.background })
      end,
    })
  end,
}
