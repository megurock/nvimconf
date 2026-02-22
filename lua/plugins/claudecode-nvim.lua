return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim", -- Claude Code ターミナル UI をサポート (必要)
    },
    config = function()
      -- 基本は config = true でも自動設定されるけど、
      -- カスタム設定したい場合は setup を呼べるよ
      require("claudecode").setup({
        -- terminal コマンドパスを変えたい場合は terminal_cmd に指定
        -- terminal_cmd = "/path/to/your/claude",

        -- ログのレベルを変える
        log_level = "info",

        -- diff 表示のオプションなど
        diff_opts = {
          auto_close_on_accept = true,
          vertical_split = true,
        },
      })
    end,
    keys = {
      -- キーバインド例
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Terminal" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Current Buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Visual Selection" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Diff" },
    },
  },
}
