return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- jdtls requires java 17, but I can't use it :)
        -- jdtls = {},
        elixirls = {},
      },
    },
  },
}
