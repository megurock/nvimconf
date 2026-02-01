return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  filters = {
    custom = { ".DS_Store" },
  },
  keys = {
    -- トグル（今まで通り）
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },

    -- フォーカス or 開く
    {
      "<leader>E",
      function()
        local api = require("nvim-tree.api")

        if api.tree.is_visible() then
          api.tree.focus()
        else
          api.tree.open()
        end
      end,
      desc = "Focus File Explorer (open if closed)",
    },
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        custom = { ".DS_Store" },
      },
    })
  end,
}

