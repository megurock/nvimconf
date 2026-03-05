local M = {}

local function press_enter_in_normal_mode()
  local enter_key = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
  vim.api.nvim_feedkeys(enter_key, 'n', false)
end

local function find_link_target_in_line(line, cursor_col)
  local search_start = 1
  while true do
    local start_col, end_col, target = line:find('%[[^%]]-%]%(([^)]+)%)', search_start)
    if not start_col then
      break
    end

    if cursor_col >= start_col and cursor_col <= end_col then
      return target
    end

    search_start = end_col + 1
  end

  search_start = 1
  while true do
    local start_col, end_col, target = line:find('<a%s+[^>]-href=["\']([^"\']+)["\'][^>]*>', search_start)
    if not start_col then
      break
    end

    if cursor_col >= start_col and cursor_col <= end_col then
      return target
    end

    search_start = end_col + 1
  end

  return nil
end

local function normalize_link_target(raw_target)
  local target = vim.trim(raw_target)
  target = target:gsub('^<', ''):gsub('>$', '')

  local path_with_title = target:match('^([^%s]+)%s+["\'].*["\']$')
  if path_with_title then
    target = path_with_title
  end

  return target
end

function M.open_link_under_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local cursor_col = cursor[2] + 1

  local target = find_link_target_in_line(line, cursor_col)
  if not target or target == '' then
    target = vim.fn.expand('<cfile>')
  end

  if not target or target == '' then
    press_enter_in_normal_mode()
    return
  end

  local normalized_target = normalize_link_target(target)
  if normalized_target:match('^https?://') or normalized_target:match('^mailto:') then
    vim.ui.open(normalized_target)
    return
  end

  local file_path = normalized_target:gsub('[?#].*$', '')
  if file_path == '' then
    vim.notify('リンク先のファイルを特定できませんでした: ' .. normalized_target, vim.log.levels.WARN)
    return
  end

  local resolved_path = file_path
  if file_path:sub(1, 1) == '/' then
    resolved_path = vim.fn.fnamemodify(file_path, ':p')
  else
    resolved_path = vim.fn.fnamemodify(vim.fn.expand('%:p:h') .. '/' .. file_path, ':p')
  end

  if vim.fn.filereadable(resolved_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(resolved_path))
    return
  end

  vim.notify('リンク先ファイルが見つかりません: ' .. file_path, vim.log.levels.WARN)
end

return M
