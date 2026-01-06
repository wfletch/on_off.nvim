local M = {}
local util= require("on_off.util")

function M.ToggleBooleanOnLine(opts)
  opts = opts or {}
  opts.level = util.validate_level(opts.level)
  opts.notify_duration = opts.notify_duration or 2000
  local line = vim.api.nvim_get_current_line()
  local row,col = unpack(vim.api.nvim_win_get_cursor(0))
  local did_not_process = line:sub(1, col)
  line = line:sub(col+1)
  local replacements = {
      ["true"] = "false",
      ["false"] = "true",
      ["True"] = "False",
      ["False"] = "True",
  }

  local new_line = ""
  local replaced = 0
  for word in line:gmatch("%a+") do
      if replacements[word] then
          local pattern = "%f[%w]" .. word .. "%f[%W]"
          new_line, replaced = line:gsub(pattern, function(match)
              return replacements[match]
          end, 1)
          break
      end
  end

  if replaced > 0 then
      vim.api.nvim_set_current_line(did_not_process .. new_line)
  else
      util.notify(
          "No Togglable Value Found On Line " .. row,
          opts.level,
          {
              title = "Togglable (On/Off)",
              timeout = opts.notify_duration,
          }
      )
  end

end
return M
