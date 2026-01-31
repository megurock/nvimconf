return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",        -- Git 差分表示
    "nvim-tree/nvim-web-devicons",    -- ファイルアイコン
  },

  init = function()
    -- barbar は setup 前に false にする必要あり
    vim.g.barbar_auto_setup = false
  end,

  opts = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,

    icons = {
      button = "",

      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN]  = { enabled = true },
        [vim.diagnostic.severity.INFO]  = { enabled = false },
        [vim.diagnostic.severity.HINT]  = { enabled = false },
      },

      gitsigns = {
        added   = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },

      filetype = {
        enabled = true,
      },
    },
  },

  config = function(_, opts)
    require("barbar").setup(opts)

    -- タブラインは常に表示
    vim.opt.showtabline = 2

    local map = vim.keymap.set
    local opts_silent = { silent = true }

    -- =========================
    -- タブ（バッファ）移動
    -- =========================
    map("n", "<Tab>",     "<Cmd>BufferNext<CR>",     opts_silent)
    map("n", "<S-Tab>",   "<Cmd>BufferPrevious<CR>", opts_silent)

    -- 数字でジャンプ（1〜9）
    for i = 1, 9 do
      map("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", opts_silent)
    end

    -- =========================
    -- タブ操作
    -- =========================
    map("n", "<leader>bd", "<Cmd>BufferClose<CR>", opts_silent) -- 閉じる
    map("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", opts_silent) -- 他を閉じる
    map("n", "<leader>bp", "<Cmd>BufferPin<CR>", opts_silent) -- ピン留め

    -- =========================
    -- 並び替え
    -- =========================
    map("n", "<leader><", "<Cmd>BufferMovePrevious<CR>", opts_silent)
    map("n", "<leader>>", "<Cmd>BufferMoveNext<CR>",     opts_silent)
  end,

  version = "^1.0.0",
}

