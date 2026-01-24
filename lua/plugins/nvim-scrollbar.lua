-- lua/plugins/nvim-scrollbar.lua
return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "kevinhwang91/nvim-hlslens",
  },
  config = function()
    require("scrollbar").setup({})

    -- optional handlers
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar.handlers.search").setup()
  end,
}
