local util = require('null-ls.utils')
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        -- jdtls requires java 17, but I can't use it :)
        -- jdtls = {},
        elixirls = {},
        denols = {
          root_dir = util.root_pattern("deno.json", "deno.jsonc")
        },
        tsserver = {
          single_file_support = false,
          root_dir = util.root_pattern("package.json")
        },
        gopls = {}
      },
    },
  },
}
