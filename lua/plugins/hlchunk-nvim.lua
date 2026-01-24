return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      indent = {
        enable = true,
        style = {
          "#333333",
        },
      },
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "┌",
          left_bottom = "└",
          right_arrow = "▶",
        },
        style = {
          "#aa00ff",
        },
      },
      line_num = {
        enable = false,
      },
    })
  end,
}
