return {
  {
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },

  {
    "nubunto/hop.nvim",
    branch = "fix-empty-line-hint",
    config = function()
      require("hop").setup({})
    end,
    event = "BufEnter",
  },

  {
    'ThePrimeagen/harpoon',
    config = function ()
      require('harpoon').setup()
    end,
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
}
