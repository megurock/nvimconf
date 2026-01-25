vim.o.number = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.ruler = true

-- fold を有効化
vim.o.foldmethod = 'indent'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'

-- リーダーの設定
vim.g.mapleader = ' '

-- 危険な Unicode 空白をハイライト
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.fn.matchadd(
      "ExtraWhitespace",
      "[\u{00A0}\u{2000}-\u{200B}\u{3000}]"
    )
    vim.api.nvim_set_hl(0, "ExtraWhitespace", {
      underline = true,
      sp = "#ff0088",  -- 下線の色
    })
  end,
})
