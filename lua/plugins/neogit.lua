-- plugins/neogit_diffview.lua
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    -- 追加
    {
      "isakbm/gitgraph.nvim",
      opts = {
        symbols = {
          merge_commit = "",
          commit = "",
        },
        format = {
          timestamp = "%H:%M:%S %d-%m-%Y",
          fields = { "hash", "timestamp", "author", "branch_name", "subject" },
        },
        hooks = {
          on_select_commit = function(commit)
            -- Enter で diffview を開く
            vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
          end,
        },
      },
    },
  },

  config = function()
    local neogit = require("neogit")

    neogit.setup({
      integrations = {
        diffview = true,
      },
      disable_commit_confirmation = true,
      signs = {
        added     = "+",
        changed   = "~",
        removed   = "-",
        untracked = "?",
      },
      kind = "split",

      -- ★ここが neogit × gitgraph の肝
      log_view = {
        kind = "split",
        renderer = "gitgraph",
      },
    })

    -- Neogit 起動
    vim.keymap.set("n", "<leader>g", function()
      neogit.open({ kind = "split" })
    end, { noremap = true, silent = true })

    -- Git graph を直接開きたい場合
    vim.keymap.set("n", "<leader>G", function()
      require("gitgraph").draw({}, { all = true, max_count = 500 })
    end, { noremap = true, silent = true })

    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,
      show_help_hints = true,
    })
  end,
}

