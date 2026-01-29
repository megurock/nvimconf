return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },  -- Git 対応バッファで遅延ロード
  opts = {
    signs = {
      add          = { text = "+" },   -- 追加行
      change       = { text = "±" },   -- 変更行
      delete       = { text = "-" },   -- 削除
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,       -- サインカラムを表示
    numhl      = false,      -- 行番号ハイライト
    linehl     = false,      -- 行全体ハイライト
    word_diff  = true,       -- 単語単位 diff (視認性アップ)
    watch_gitdir = {
      follow_files = true,   -- ファイル移動追従
      interval = 1000,
    },
    attach_to_untracked = true, -- 未追跡ファイルにもアタッチ
    current_line_blame = true,  -- blame を表示
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",   -- blame 表示位置
      delay = 500,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  },

  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- on_attach でキーマッピングを設定
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- hunk ナビゲーション
        map("n", "]c", gitsigns.next_hunk, "Next Git Hunk")
        map("n", "[c", gitsigns.prev_hunk, "Prev Git Hunk")

        -- hunk 操作
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Visual Hunk")
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Visual Hunk")

        -- バッファ全体
        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")

        -- プレビュー / blame / diff
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Hunk")
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Inline Preview")
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hd", gitsigns.diffthis, "Diff This")
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, "Diff This w/ HEAD~")

        -- クイックリスト / ローカルリスト
        map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, "Git Quickfix all")
        map("n", "<leader>hq", gitsigns.setqflist, "Git Quickfix buffer")

        -- トグル系
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle Blame")
        map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word-diff")

        -- text object: hunk 選択
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select Git Hunk")
      end,
    })
  end,
}

