return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("nvim-treesitter.configs not found", vim.log.levels.WARN)
      return
    end

    ts_configs.setup {
      ensure_installed = {
        "bash","css","dockerfile","fish","git_config","gitcommit","gitignore",
        "html","javascript","json","lua","markdown","markdown_inline","mermaid",
        "pug","scss","sql","toml","typescript","tsx","vim","vimdoc","vue","yaml",
      },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local ok = pcall(vim.treesitter.get_parser, buf, lang)
          return not ok
        end,
      },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      callback = function()
        local lang = vim.bo.filetype
        local ok, parser = pcall(vim.treesitter.get_parser, 0, lang)
        if ok and parser then
          vim.treesitter.start()
        end
      end,
    })
  end
}
