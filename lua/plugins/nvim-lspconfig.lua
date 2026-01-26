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

    -- =========================
    -- biome 専用設定
    -- =========================
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
        local has_pnpm_lock =
          vim.fn.filereadable(root_dir .. "/pnpm-lock.yaml") == 1
          or vim.fn.filereadable(root_dir .. "/pnpm-lock.yml") == 1

        local has_local_biome =
          vim.fn.filereadable(root_dir .. "/node_modules/.bin/biome") == 1

        if has_local_biome then
          if has_pnpm_lock then
            new_config.cmd = { "pnpm", "biome", "lsp-proxy" }
          else
            new_config.cmd = { "npx", "biome", "lsp-proxy" }
          end
        end
      end,
    })

    -- =========================
    -- lua_ls 専用設定
    -- =========================
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      },
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
    -- LspAttach
    -- =========================
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
          return
        end

        local function createOpts(desc)
          return { buffer = ev.buf, desc = "LSP " .. desc }
        end

        local buffer = vim.lsp.buf

        -- -------------------------
        -- 確実に戻れるジャンプ用ラッパー
        -- -------------------------
        local function lsp_jump(fn)
          return function()
            vim.cmd("normal! m'")
            fn()
          end
        end

        -- 基本 LSP 操作（すべて戻れる）
        vim.keymap.set(
          "n",
          "GD",
          lsp_jump(buffer.definition),
          createOpts("Go to definition")
        )

        vim.keymap.set(
          "n",
          "GI",
          lsp_jump(buffer.implementation),
          createOpts("Go to implementation")
        )

        vim.keymap.set(
          "n",
          "GR",
          lsp_jump(buffer.references),
          createOpts("Show references")
        )

        vim.keymap.set(
          "n",
          "GY",
          lsp_jump(buffer.type_definition),
          createOpts("Go to type definition")
        )

        -- biome 専用：保存時フォーマット
        if client.name == "biome" then
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

        -- code action
        if client.supports_method("textDocument/codeAction") then
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            createOpts("Code action")
          )
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

    -- Biome Check
    vim.keymap.set("n", "<leader>cw", function()
      local filepath = vim.fn.expand("%:p")
      vim.cmd("silent !biome check --write " .. vim.fn.shellescape(filepath))
      vim.cmd("edit!")
    end, { desc = "Biome check --write" })
  end,
}

