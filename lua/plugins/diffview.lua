-- plugins/neogit_diffview.lua
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    local neogit = require("neogit")

    -- Neogit の設定
    neogit.setup({
      integrations = {
        diffview = true, -- diffview と統合
      },
      disable_commit_confirmation = true,
      signs = {
        added    = "+",
        changed  = "~",
        removed  = "-",
        untracked = "?",
      },
      kind = "split",  -- 左側に分割表示
    })

    -- キーマップ: <leader>g で Neogit を左側に表示
    vim.keymap.set("n", "<leader>g", function()
      neogit.open({ kind = "split" })
    end, { noremap = true, silent = true })

    -- diffview.nvim の設定（簡易版）
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,
      show_help_hints = true,
    })
  end,
}
