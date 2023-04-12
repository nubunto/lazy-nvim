-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map({ "n" }, "<leader>o", "<cmd>Neotree toggle<cr>")
map({ "n" }, "<leader>c", "<cmd>bd<cr>")

-- Hop keymaps
local hop = require("hop")
local directions = require("hop.hint").HintDirection

map({ "" }, "f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

map({ "" }, "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })

map({ "" }, "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })

map({ "" }, "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

map({ "n" }, "s", function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR })
end)

map({ "n" }, "S", function()
  hop.hint_char2({ direction = directions.BEFORE_CURSOR })
end)

map({ "n" }, "<leader>p", function()
  hop.hint_patterns({ direction = directions.AFTER_CURSOR })
end)

map({ "n" }, "<leader>P", function()
  hop.hint_patterns({ direction = directions.BEFORE_CURSOR })
end)
