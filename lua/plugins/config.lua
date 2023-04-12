return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  { "lunarvim/Onedarker.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedarker",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  {
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({})
    end,
    event = "BufEnter",
  },
}
