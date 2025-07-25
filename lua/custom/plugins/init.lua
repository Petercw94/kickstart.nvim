-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- File: lua/custom/plugins/init.lua

return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.black.with {
            extra_args = { '--fast' },
          },
        },
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.py',
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })

      vim.api.nvim_create_user_command('Format', function()
        vim.lsp.buf.format()
      end, {})
    end,
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
      lsp = {
        progress = {
          suppress_on_insert = true,
        },
        override = {
          -- ✅ THIS disables Fidget's hover handler override
          ['textDocument/hover'] = false,
        },
      },
    },
  },
}
