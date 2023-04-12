return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        -- jdtls requires java 17, but I can't use it :)
        -- jdtls = {},
        elixirls = {},
      },
    },
  },
}
