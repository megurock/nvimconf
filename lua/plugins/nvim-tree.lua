return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    -- トグル
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
    local function open_in_browser(node)
      local path = node.absolute_path
      if not path then
        return
      end

      -- ディレクトリは無視
      if node.type == "directory" then
        return
      end

      -- macOS
      vim.fn.jobstart({ "open", path }, { detach = true })

      -- Linux の場合
      -- vim.fn.jobstart({ "xdg-open", path }, { detach = true })

      -- Windows の場合
      -- vim.fn.jobstart({ "cmd.exe", "/c", "start", path }, { detach = true })
    end

    require("nvim-tree").setup({
      filters = {
        custom = { ".DS_Store" },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        api.config.mappings.default_on_attach(bufnr)

        -- B でブラウザ表示
        vim.keymap.set("n", "B", function()
          local node = api.tree.get_node_under_cursor()
          open_in_browser(node)
        end, {
          buffer = bufnr,
          desc = "Open in browser",
        })
      end,
    })
  end,
}
