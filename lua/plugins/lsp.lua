return {
  "neovim/nvim-lspconfig",
  config = function()
    -- =========================
    -- Capabilities
    -- =========================
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- =========================
    -- Global LSP config
    -- =========================
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- biome 専用設定（ローカル優先、グローバルフォールバック）
    vim.lsp.config("biome", {
      cmd = { "biome", "lsp-proxy" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "css",
      },
      root_markers = { "biome.json", "biome.jsonc" },
      single_file_support = false,
      on_new_config = function(new_config, root_dir)
        -- pnpm プロジェクトかチェック
        local has_pnpm_lock = vim.fn.filereadable(root_dir .. "/pnpm-lock.yaml") == 1
          or vim.fn.filereadable(root_dir .. "/pnpm-lock.yml") == 1

        -- ローカルに biome がインストールされているかチェック
        local has_local_biome = vim.fn.executable(root_dir .. "/node_modules/.bin/biome") == 1

        if has_local_biome then
          if has_pnpm_lock then
            new_config.cmd = { "pnpm", "biome", "lsp-proxy" }
          else
            new_config.cmd = { "npx", "biome", "lsp-proxy" }
          end
        end
        -- ローカルになければグローバルの biome を使用（デフォルトのまま）
      end,
    })

    -- =========================
    -- Enable LSP servers
    -- =========================
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("cssls")
    vim.lsp.enable("html")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("biome")

    -- =========================
    -- LspAttach（動的な機能も含めて判定）
    -- =========================
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
          return
        end

        local function createOpts(description)
          return { buffer = ev.buf, desc = "LSP " .. description }
        end

        local buffer = vim.lsp.buf

        -- 基本 LSP 操作
        vim.keymap.set("n", "gD", buffer.declaration, createOpts("Go to declaration"))
        vim.keymap.set("n", "gd", buffer.definition, createOpts("Go to definition"))
        vim.keymap.set("n", "gi", buffer.implementation, createOpts("Go to implementation"))
        vim.keymap.set("n", "gr", buffer.references, createOpts("Show references"))

        -- biome 専用設定
        if client.name == "biome" then
          -- 保存時フォーマット
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            desc = "Format on save with Biome",
            callback = function()
              vim.lsp.buf.format({
                filter = function(c)
                  return c.name == "biome"
                end,
                timeout_ms = 2000,
              })
            end,
          })
        end

        -- code action のあるLSPのみ設定
        if client.supports_method("textDocument/codeAction") then
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, createOpts("Code action"))
        end
      end,
    })

    -- =========================
    -- Biome manual actions
    -- =========================

    -- Biome Lint
    vim.keymap.set("n", "<leader>lw", function()
      local filepath = vim.fn.expand("%:p")
      vim.cmd("silent !biome lint --write " .. vim.fn.shellescape(filepath))
      vim.cmd("edit!")
    end, { desc = "Biome lint --write" })

    -- Biome Format
    vim.keymap.set("n", "<leader>fw", function()
      local filepath = vim.fn.expand("%:p")
      vim.cmd("silent !biome format --write " .. vim.fn.shellescape(filepath))
      vim.cmd("edit!")
    end, { desc = "Biome format --write" })

    -- Biome Check (lint + format + organize imports)
    vim.keymap.set("n", "<leader>cw", function()
      local filepath = vim.fn.expand("%:p")
      vim.cmd("silent !biome check --write " .. vim.fn.shellescape(filepath))
      vim.cmd("edit!")
    end, { desc = "Biome check --write" })
  end,
}
