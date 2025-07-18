return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.o.laststatus = 3 -- works better with globalstatus

    require('lualine').setup {
      globalstatus = true,
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_show_tabline = false,
      },
      tabline = {
        lualine_z = {
          'tabs',
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
              local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
              local target_len = vim.o.columns / 7
              if string.len(cwd) > target_len then
                return string.sub(cwd, 1, target_len) .. '…'
              else
                return cwd
              end
            end,
            icon = '', -- Same as my powerline prompt
          },
          {
            'branch',
            icon = '',
            fmt = function(str)
              local target_len = vim.o.columns / 7
              if string.len(str) > target_len then
                return string.sub(str, 1, target_len) .. '…'
              else
                return str
              end
            end,
          },
          'diagnostics',
        },
        lualine_c = {
          {
            function()
              local summary = vim.b.minidiff_summary
              if not summary then
                return ''
              end

              local result = ''
              if summary.add and summary.add > 0 then
                result = result .. '%#MiniDiffSignAdd#+' .. summary.add .. '%* '
              end
              if summary.change and summary.change > 0 then
                result = result .. '%#MiniDiffSignChange#~' .. summary.change .. '%* '
              end
              if summary.delete and summary.delete > 0 then
                result = result .. '%#MiniDiffSignDelete#-' .. summary.delete .. '%*'
              end

              return result
            end,
          },
        },
        lualine_x = {
          {
            'filename',
            path = 1,
            fmt = function(str)
              local parts = vim.split(str, '/')
              local filename = parts[#parts]

              local filename_hl_name = 'LualineFilename'
              -- local gitsigns = vim.b.gitsigns_status_dict
              -- if gitsigns and (gitsigns.changed ~= nil or gitsigns.added ~= nil or gitsigns.removed ~= nil) then
              --   filename_hl_name = 'LualineFilenameChanged'
              -- end

              filename = '%#' .. filename_hl_name .. '#' .. filename .. '%*'

              -- local is_index_file = filename:match '^index%..+$'
              if #parts == 1 then
                return filename
              else
                local filepath = table.concat(parts, '/', 1, #parts - 1)
                return '%#LualineFilepath#' .. filepath .. '/' .. '%*' .. filename
              end
            end,
            separator = '',
          },
          { 'filetype', icon_only = true, padding = 0, separator = '' },
          {
            function()
              local chars = { '⎺', '⎻', '─', '⎼', '⎽' }

              local progress = math.floor((vim.fn.line '.' / vim.fn.line '$') * 100)
              local indexBucket = math.min(#chars, math.floor(progress / (100 / #chars)) + 1)
              local progressChar = chars[indexBucket]

              return progressChar
            end,
            padding = { left = 0, right = 1 },
            color = { fg = '#ff0000' },
          },
        },
        lualine_y = {
          -- {
          --   require('noice').api.status.command.get,
          --   cond = require('noice').api.status.command.has,
          -- },
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            fmt = function(str)
              return '󰑋 ' .. string.sub(str, #str)
            end,
            color = { fg = '#ff0000' },
          },
          {
            'searchcount',
            icon = '',
            fmt = function(str)
              return str:gsub('[%[%]|]', '')
            end,
          },
          {
            'grapple',
            padding = { left = 1, right = 0 },
          },
        },
        lualine_z = {},
      },
    }

    local function createHighlights()
      local lualine_a_hl = vim.api.nvim_get_hl(0, { name = 'lualine_a_normal' })
      local lualine_b_hl = vim.api.nvim_get_hl(0, { name = 'lualine_b_normal' })
      local lualine_c_hl = vim.api.nvim_get_hl(0, { name = 'lualine_c_normal' })
      local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })

      vim.api.nvim_set_hl(0, 'LualineFilepath', {
        italic = true,
        fg = comment_hl.fg,
        bg = lualine_c_hl.bg,
      })
      vim.api.nvim_set_hl(0, 'LualineFilename', {
        bold = true,
        fg = lualine_c_hl.fg,
        bg = lualine_c_hl.bg,
      })
      vim.api.nvim_set_hl(0, 'GrappleActive', {
        bold = true,
        fg = lualine_b_hl.fg,
        bg = lualine_b_hl.bg,
      })
      vim.api.nvim_set_hl(0, 'GrappleInactive', {
        fg = comment_hl.fg,
        bg = lualine_b_hl.bg,
      })
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        -- Schedule so we can wait for lualine to set up its highlights
        vim.schedule(createHighlights)
      end,
    })

    createHighlights()
  end,
}
