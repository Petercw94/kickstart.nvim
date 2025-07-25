-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, for icons
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      -- optional config here
    }

    -- Add keymap here
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = '[E]xplorer Toggle Neo-tree' })
  end,
}
