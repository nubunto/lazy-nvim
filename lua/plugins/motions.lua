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
}
