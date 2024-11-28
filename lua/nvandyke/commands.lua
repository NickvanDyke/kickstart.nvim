-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Trigger autoread (in case file changed externally)',
  callback = function()
    vim.cmd 'checktime'
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  callback = function()
    local is_modified = vim.api.nvim_buf_get_option(0, 'modified')
    -- if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
    if is_modified then
      vim.cmd 'silent w'

      -- local time = os.date '%I:%M %p'

      vim.notify('autosaved', vim.log.levels.INFO, { timeout = 100 })
    end
  end,
})
