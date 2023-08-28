return {
  {
    "rcarriga/nvim-notify",
    enabled = true,
  },

  {

    "folke/noice.nvim",
    enabled = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.default_component_configs.symbols = {
        -- Change type
        added = "✚",
        deleted = "✖",
        modified = "",
        renamed = "",

        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      }
      opts.window = { position = "right" }
      opts.close_if_last_window = true
      opts.log_level = "error"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            text_align = "right",
          },
        },
      },
    },
  },
}
