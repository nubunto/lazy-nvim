local util = require("null-ls.utils")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        sources = {
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.goimports,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        -- jdtls requires java 17, but I can't use it :)
        -- jdtls = {},
        elixirls = {},
        denols = {
          root_dir = util.root_pattern("deno.json", "deno.jsonc"),
        },
        tsserver = {
          single_file_support = false,
          root_dir = util.root_pattern("package.json"),
        },
        gopls = {},
      },
    },
  },
}
