-- lua/plugins/treesitter-context.lua
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",  -- 必須: treesitter 本体
  },
  config = function()
    require("treesitter-context").setup({
      enable = true,            -- true で表示
      max_lines = 3,            -- 上部に表示する最大行数（0=無制限）
      line_numbers = true,      -- 行番号を表示
      multiline_threshold = 20, -- 長いコンテキストの閾値
      trim_scope = "outer",     -- 制限超過時のトリム方法
      mode = "cursor",          -- カーソル位置ベース
      separator = nil,          -- 区切り文字 （表⽰したい場合は "-" など）
    })
  end,
}
