-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  opts = {
    direction = "horizontal",
    size = 15,
  },
  config = function(_, opts)
    local toggleterm = require("toggleterm")
    toggleterm.setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal
    local float_term = nil  -- float 専用ターミナル

    -- horizontal ターミナルを開く
    vim.keymap.set("n", "<leader>t", function()
      local term = Terminal:new({
        direction = "horizontal",
        size = 15,
        close_on_exit = false,
      })
      term:toggle()
    end, { desc = "Open new horizontal terminal" })

    -- vertical ターミナルを開く
    vim.keymap.set("n", "<leader>tv", function()
      local term = Terminal:new({
        direction = "vertical",
        size = 80,
        close_on_exit = false,
      })
      term:toggle()
    end, { desc = "Open new vertical terminal" })

    -- float ターミナルを開く
    vim.keymap.set("n", "<leader>tf", function()
      if not float_term then
        float_term = Terminal:new({
          direction = "float",
          close_on_exit = false,
          float_opts = {
            border = "curved",
            width = 100,
            height = 30,
            winblend = 3,
          },
        })
      end
      float_term:toggle()
    end, { desc = "Open floating terminal" })

    -- ターミナルモードのキーマップ
    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

    -- float ターミナル専用の閉じるキー
    vim.keymap.set("t", "<C-c>", function()
      if float_term and float_term:is_open() then
        float_term:close()
      end
    end, { desc = "Close floating terminal" })
  end,
}
