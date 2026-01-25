-- lua/plugins/glance-nvim.lua
return {
  "dnlhc/glance.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "gd", "<CMD>Glance definitions<CR>" },
    { "gr", "<CMD>Glance references<CR>" },
    { "gi", "<CMD>Glance implementations<CR>" },
    { "gy", "<CMD>Glance type_definitions<CR>" },
  },
  config = function()
    require("glance").setup()
  end,
}