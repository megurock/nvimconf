return {
  'nvim-telescope/telescope.nvim',
  cmd = { "Telescope" },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { "<leader>p", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>g", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
  },
  config = function()
    require("telescope").setup {}
    pcall(require("telescope").load_extension, "fzf")
  end,
}
