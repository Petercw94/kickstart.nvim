vim.defer_fn(function()
  vim.lsp.buf.hover = function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, result, ctx, config)
      if not (result and result.contents) then
        return
      end

      local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
      if vim.tbl_isempty(markdown_lines) then
        return
      end

      local width = math.floor(vim.o.columns * 0.4)
      local height = math.floor(vim.o.lines * 0.6)
      local col = vim.o.columns - width - 2

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
      vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

      local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        anchor = 'NW',
        row = 1,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
      })

      local opts = { silent = true, nowait = true, buffer = buf }
      vim.keymap.set('n', '<C-f>', '<C-d>', opts)
      vim.keymap.set('n', '<C-b>', '<C-u>', opts)
      vim.keymap.set('n', 'q', '<cmd>close<CR>', opts)
    end)
  end
end, 1000)
