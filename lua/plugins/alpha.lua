math.randomseed(os.time())

local function f(str)
  local outer_env = _ENV
  return (
    str:gsub("%b{}", function(block)
      local code = block:match("{(.*)}")
      local exp_env = {}
      setmetatable(exp_env, {
        __index = function(_, k)
          local stack_level = 5
          while debug.getinfo(stack_level, "") ~= nil do
            local i = 1
            repeat
              local name, value = debug.getlocal(stack_level, i)
              if name == k then
                return value
              end
              i = i + 1
            until name == nil
            stack_level = stack_level + 1
          end
          return rawget(outer_env, k)
        end,
      })
      local fn, err = load("return " .. code, "expression `" .. code .. "`", "t", exp_env)
      if fn then
        return tostring(fn())
      else
        error(err, 0)
      end
    end)
  )
end

local function random_phrase()
  local phrases_path = vim.fn.stdpath("config").."/alpha/phrases.lua"
  local phrases = { 'I choose violence today' }
  if vim.loop.fs_stat(phrases_path) then
    local phrases_file = assert( loadfile(phrases_path) )
    phrases = phrases_file()
  end
  local phrase = phrases[math.random(#phrases)]
  local middle = f"| {phrase} |"
  local rep = string.rep("-", string.len(middle)-2)
  local border = f"x{rep}x"

  return {
    border = border,
    middle = middle,
  }
end

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local phrase_box = random_phrase()

    local logo = f([[
      NO!                          MNO!
     MNO!!         [NBK]          MNNOO!
   MMNO!                           MNNOO!!
 MNOONNOO!   MMMMMMMMMMPPPOII!   MNNO!!!!
 !O! NNO! MMMMMMMMMMMMMPPPOOOII!! NO!
       ! MMMMMMMMMMMMMPPPPOOOOIII! !
        MMMMMMMMMMMMPPPPPOOOOOOII!!
        MMMMMOOOOOOPPPPPPPPOOOOMII!
        MMMMM..    OPPMMP    .,OMI!
        MMMM::   o.,OPMP,.o   ::I!!
          NNM:::.,,OOPM!P,.::::!!
         MMNNNNNOOOOPMO!!IIPPO!!O!
         MMMMMNNNNOO:!!:!!IPPPPOO!
          MMMMMNNOOMMNNIIIPPPOO!!
             MMMONNMMNNNIIIOO!
           MN MOMMMNNNIIIIIO! OO
          MNO! IiiiiiiiiiiiI OOOO
     NNN.MNO!   O!!!!!!!!!O   OONO NO!
    MNNNNNO!    OOOOOOOOOOO    MMNNON!
      MNNNNO!    PPPPPPPPP    MMNON!
         OO!                   ON!
      ]])
    opts.section.header.val = vim.split(logo, "\n")
  end,
}
