return {
  'nvim-focus/focus.nvim',
  config = function()
    -- Taken from readme
    local ignore_filetypes = { 'trouble' }
    local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

    local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

    vim.api.nvim_create_autocmd('WinEnter', {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          vim.w.focus_disable = true
        else
          vim.w.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for BufType',
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        else
          vim.b.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for FileType',
    })

    vim.keymap.set('n', '<c-;>', function()
      require('focus').split_nicely()
    end, { desc = 'split nicely' })

    require('focus').setup {
      ui = {
        signcolumn = false,
      },
    }
  end,
}