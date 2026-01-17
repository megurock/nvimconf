return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require('nvim-treesitter').setup {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "fish",
        "git_config",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "mermaid",
        "pug",
        "scss",
        "sql",
        "toml",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
      },
    }

    -- ファイル読み込み時に自動でハイライトを有効化
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      callback = function()
        vim.treesitter.start()
      end,
    })
  end
}