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
    print(string.len(phrase_box.border), string.len(phrase_box.middle))

    local logo = f([[
                          :::!~!!!!!:.
                      .xUHWH!! !!?M88WHX:.
                    .X*#M@$!!  !X!M$$$$$$WWx:.
                  :!!!!!!?H! :!$!$$$$$$$$$$8X:
                  !!~  ~:~!! :~!$!#$$$$$$$$$$8X:
                :!~::!H!<   ~.U$X!?R$$$$$$$$MM!
                ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!
                  !:~~~ .:!M"T#$$$$WX??#MRRMMM!
                  ~?WuxiW*`   `"#$$$$8!!!!??!!!
                :X- M$$$$       `"T#$T~!8$WUXU~
                :%`  ~#$$$m:        ~!~ ?$$$$$$
              :!`.-   ~T$$$$8xx.  .xWW- ~""##*"
    .....   -~~:<` !    ~?T#$$@@W@*?$$      /`
    W$@@M!!! .!~~ !!     .:XUW$W!~ `"~:    :
    #"~~`.:x%`!!  !H:   !WM$$$$Ti.: .!WUn+!`
    :::~:!!`:X~ .: ?H.!u "$$$B$$$!W:U!T$$M~
    .~~   :X@!.-~   ?@WTWo("*$$$W$TH$! `
    Wi.~!X$?!-~    : ?$$$B$Wu("**$RM!     {phrase_box.border}
    $R@i.~~ !     :   ~$$$$$B$$en:`` ---- {phrase_box.middle}
    ?MXT@Wx.~    :     ~"##*$$$$M~        {phrase_box.border}
      ]])
    opts.section.header.val = vim.split(logo, "\n")
  end,

}
