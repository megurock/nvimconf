-- ========================================
-- IME自動切替設定（macOS専用）
-- ========================================
-- ノーマルモードに戻るとき IME をオフに（英数キー送信）
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.fn.system([[
      /usr/bin/osascript -e 'tell application "System Events" to key code 102'
    ]])
  end,
})
