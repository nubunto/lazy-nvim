return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.default_component_configs.symbols = {
        -- Change type
        added     = "✚",
        deleted   = "✖",
        modified  = "",
        renamed   = "",

        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
    }
    opts.close_if_last_window = true
    opts.log_level = "error"
  end,
}
