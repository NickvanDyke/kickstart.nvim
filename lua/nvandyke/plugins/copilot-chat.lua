return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    window = {
      -- layout = 'horizontal',
    },
  },
  cmd = { 'CopilotChat' },
  keys = {
    {
      mode = { 'n', 'x' },
      '<leader>cc',
      function()
        require('CopilotChat').toggle()
      end,
      desc = 'CopilotChat',
    },
  },
  init = function()
    vim.cmd [[cab cc CopilotChat]]
  end,
}
