-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { ".go" },
  callback = function(opts)
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(opts.buf))
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(opts.buf, "textDocument/codeAction", params, 3000)
    for _, res in ipairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(opts.buf))
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})
