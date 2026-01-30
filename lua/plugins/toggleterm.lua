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

    -- terminal id を一元管理
    local term_id = 0
    local function next_id()
      term_id = term_id + 1
      return term_id
    end

    -- float 専用（singleton）
    local float_term = nil

    ------------------------------------------------------------------
    -- horizontal terminal
    ------------------------------------------------------------------
    vim.keymap.set("n", "<leader>t", function()
      local term = Terminal:new({
        id = next_id(),
        direction = "horizontal",
        size = 15,
        close_on_exit = false,
      })
      term:toggle()
    end, { desc = "Open new horizontal terminal" })

    ------------------------------------------------------------------
    -- vertical terminal
    ------------------------------------------------------------------
    vim.keymap.set("n", "<leader>tv", function()
      local width = math.floor(vim.o.columns * 0.35)

      local term = Terminal:new({
        id = next_id(),
        direction = "vertical",
        size = width,
        close_on_exit = false,
      })

      term:toggle()

      -- toggleterm の size 制限を上書き
      vim.cmd("vertical resize " .. width)
    end, { desc = "Open new vertical terminal" })

    ------------------------------------------------------------------
    -- floating terminal（singleton）
    ------------------------------------------------------------------
    vim.keymap.set("n", "<leader>tf", function()
      if not float_term then
        float_term = Terminal:new({
          id = 999,
          direction = "float",
          close_on_exit = false,
          float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            winblend = 3,
          },
        })
      end
      float_term:toggle()
    end, { desc = "Open floating terminal" })

    ------------------------------------------------------------------
    -- terminal mode keymaps
    ------------------------------------------------------------------
    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
      desc = "Exit terminal mode",
    })

    -- float 専用 close
    vim.keymap.set("t", "<C-c>", function()
      if float_term and float_term:is_open() then
        float_term:close()
      end
    end, { desc = "Close floating terminal" })
  end,
}

