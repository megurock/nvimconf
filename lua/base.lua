vim.o.number = true
vim.o.smartindent = true
vim.o.expandtab = true  -- Tab をスペースに
vim.o.tabstop = 2       -- 見た目のタブ幅
vim.o.shiftwidth = 2    -- インデント幅
vim.o.softtabstop = 2   -- <Tab> 押下時のスペース幅
vim.o.termguicolors = true
vim.o.ruler = true
vim.o.clipboard = "unnamedplus" -- OS のクリップボードに yank する
vim.o.history = 200          -- コマンド・検索などの履歴を最大 200 件まで保持
vim.o.wildmenu = true        -- コマンドライン補完時に候補をメニュー表示する
vim.opt.wildmode = { "longest:full", "full" } -- <Tab> 補完の挙動：最長一致→候補一覧を順に表示

-- fold を有効化
vim.o.foldmethod = 'indent'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'

-- リーダーの設定
vim.g.mapleader = ' '

-- ヘルプの設定
vim.api.nvim_create_user_command("H", function(opts)
  vim.cmd("tab help " .. opts.args)
end, { nargs = "+" })

vim.keymap.set("n", "K", function()
  vim.cmd("tab help " .. vim.fn.expand("<cword>"))
end, { silent = true })

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
