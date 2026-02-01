return {
  -- ----------------------------------------
  -- Mason: LSP server management
  -- ----------------------------------------
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright", "ruff", "gopls", "lua_ls",
        "html", "cssls", "ts_ls", "jsonls",
      },
    },
  },

  -- ----------------------------------------
  -- nvim-lspconfig: LSP Main Config (Neovim 0.11+ Style)
  -- ----------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. 補完機能（cmp）との連携設定
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 2. すべてのサーバーに対するデフォルト設定
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 3. 個別のサーバー設定 (Python - Pyright)
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              -- プロジェクト内の検索パスを自動追加
              autoSearchPaths = true,
              -- ライブラリの型ヒントを使用
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      -- ---------------------------------------------------------
      -- Python (Ruff) 設定
      -- 高速リンター
      -- ---------------------------------------------------------
      vim.lsp.config("ruff", {
        -- ruffのLSP機能を使うと、ホバーでエラー詳細が見れる
        init_options = {
          settings = {
          },
        },
      })

      -- Lua
      -- 4. 個別のサーバー設定 (Lua)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- 5. 個別のサーバー設定 (HTML / Django)
      vim.lsp.config("html", {
        filetypes = { "html", "htmldjango" },
      })

      -- 6. Djangoテンプレートのファイルタイプ認識
      vim.filetype.add({
        pattern = {
          [".*/templates/.*%.html"] = "htmldjango",
        },
      })

      -- 7. サーバーを有効化 (Enable)
      -- ここに使いたいサーバー名をリストアップします
      vim.lsp.enable({
        "pyright", "ruff", "gopls", "lua_ls",
        "html", "cssls", "ts_ls", "jsonls",
      })
    end,
  },

  -- ----------------------------------------
  -- nvim-cmp: Completion engine
  -- ----------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "obsidian", option = { key = "obsidian" } }, -- Obsidian連携
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- ----------------------------------------
  -- conform.nvim: Formatter
  -- ----------------------------------------
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      { "<leader>cf", function() require("conform").format() end, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        javascript = { "prettier" },
        html = { "prettier" },
        htmldjango = { "djlint" },
        css = { "prettier" },
        json = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
