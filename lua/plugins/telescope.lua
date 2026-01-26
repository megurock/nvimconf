return {
  'nvim-telescope/telescope.nvim',
  cmd = { "Telescope" },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup {
      defaults = {
        mappings = {
          i = {
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-u>"] = actions.preview_scrolling_up,
          },
        },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
  end,
}

