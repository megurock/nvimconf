return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  config = function()
    require("colorful-winsep").setup({
      border = "single",
      highlight = "#ffffff", -- 境界線の色（文字列で fg を指定、bg は Normal に自動追従）
      animate = {
        enabled = true, -- アニメーション不要なら false
      },
    })
  end,
}

