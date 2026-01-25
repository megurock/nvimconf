-- ========================================
-- IME制御設定（macOS + im-select）
-- ========================================
-- ・Normal モードでは常に英数
-- ・vim にフォーカスが戻ったときも英数
-- ========================================

local IME_EN = "com.apple.keylayout.ABC"

-- Normal モードに戻ったら英数
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:n",
  callback = function()
    vim.fn.system({ "im-select", IME_EN })
  end,
})

-- Insert モードを抜けたときの保険
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.fn.system({ "im-select", IME_EN })
  end,
})

-- vim にフォーカスが戻ったときも英数
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.fn.system({ "im-select", IME_EN })
  end,
})

