local M = {}
function M.ToggleBooleanOnLine()
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
      vim.api.nvim_echo({ { "No boolean found on this line", "WarningMsg" } }, false, {})
  end

end
return M
