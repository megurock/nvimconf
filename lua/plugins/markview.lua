-- init.lua / plugins.lua など
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,         -- lazy loading は OFF
    priority = 49,        -- colorscheme との連携優先
    dependencies = {
      "nvim-treesitter/nvim-treesitter",  -- TS 解析用
      "nvim-tree/nvim-web-devicons",      -- optional（アイコン）
    },
    config = function()
      require("markview").setup({})

      -- split プレビューのトグル
      vim.keymap.set(
        "n",
        "<leader>md",
        "<cmd>Markview splitToggle<CR>",
        { desc = "Toggle Markview split preview" }
      )
    end,
  },
}

