local M = {}
function M.notify(msg, level, opts)
    level = level or vim.log.levels.INFO
    opts = opts or {}

    local ok, n = pcall(require, "notify")
    if ok then
        n(msg, level, opts)
    else
        vim.notify(msg, level)
    end
end

local VALID_LEVELS = {
  [vim.log.levels.TRACE] = false,
  [vim.log.levels.DEBUG] = false,
  [vim.log.levels.INFO]  = true,
  [vim.log.levels.WARN]  = true,
  [vim.log.levels.ERROR] = true,
  [vim.log.levels.OFF]   = false,
}
function M.validate_level(level)
  if level == nil then
    return vim.log.levels.WARN
  end

  if type(level) ~= "number" or not VALID_LEVELS[level] then
    error(
      "time_is_running_out: `level` must be one of vim.log.levels.{INFO,WARN,ERROR}",
      2
    )
  end

  return level
end
return M
