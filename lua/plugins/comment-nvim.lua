-- plugins/comment-nvim.lua

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",  -- lazy.nvim 用（必要でなければ削除）
  config = function()
    require("Comment").setup({
      -- 以下、必要なら好みに合わせて編集してください。
      ---Add any basic pre-hook/post-hook here if needed
      toggler = {
        ---Line-comment toggle keymap
        line = "gcc",
        ---Block-comment toggle keymap
        block = "gbc",
      },
      opleader = {
        ---Operator-pending keymap
        line = "gc",
        block = "gb",
      },
      extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at end of line
        eol = "gcA",
      },
      ---Ignore empty lines (optional)
      ignore = "^$",
    })
  end,
}

