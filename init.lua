-- ============================================
-- Basic Settings
-- ============================================
-- Tab and indent settings
vim.cmd("set expandtab")      -- Insert spaces when pressing Tab
vim.cmd("set tabstop=2")      -- Tab character display width
vim.cmd("set softtabstop=2")  -- Number of spaces inserted by Tab key
vim.cmd("set shiftwidth=2")   -- Number of spaces for auto-indent

-- Leader key settings (starting point for many keymaps)
-- Press Space, then press the next key to invoke various functions
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- System clipboard integration
-- Yanked content is also copied to macOS clipboard
vim.opt.clipboard = "unnamedplus"

-- Line number display
vim.o.number = true          -- Show absolute line number for current line
vim.o.relativenumber = true  -- Show relative line numbers for other lines

-- Display settings
vim.o.termguicolors = true   -- Enable 24-bit color
vim.o.signcolumn = "yes"     -- Always show sign column
vim.o.cursorline = true      -- Highlight cursor line

-- Search settings
vim.o.ignorecase = true      -- Ignore case when searching
vim.o.smartcase = true       -- But distinguish case if uppercase is included

-- Window split behavior
vim.o.splitbelow = true      -- Open new window below when horizontal split
vim.o.splitright = true      -- Open new window to the right when vertical split

-- Persistent undo history
vim.o.undofile = true

-- ============================================
-- lazy.nvim Bootstrap
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================
-- Plugin Definitions
-- ============================================
local plugins = {
  -- ----------------------------------------
  -- Colorscheme
  -- ----------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({})
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ----------------------------------------
  -- which-key: Keymap hint display
  -- ----------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },

  -- ----------------------------------------
  -- neo-tree: File explorer
  -- ----------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
      },
    },
  },

  -- ----------------------------------------
  -- fzf-lua: Fuzzy finder
  -- ----------------------------------------
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help tags" },
      { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
      { "<leader>fc", function() require("fzf-lua").commands() end, desc = "Commands" },
      { "<leader>sf", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<leader>sg", function() require("fzf-lua").live_grep() end, desc = "Grep" },
      { "<leader>sb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>sh", function() require("fzf-lua").help_tags() end, desc = "Help" },
      { "<leader><leader>", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<C-p>", function() require("fzf-lua").files() end, desc = "Find files" },
      { "gr", function() require("fzf-lua").lsp_references() end, desc = "References" },
      { "<leader>ds", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "down:45%",
        },
      },
    },
  },

  -- ----------------------------------------
  -- treesitter: Syntax highlighting
  -- ----------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "javascript", "typescript", "python",
          "html", "htmldjango", "css", "json", "go", "rust",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- ----------------------------------------
  -- nvim-surround: Text surrounding operations
  -- ----------------------------------------
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ----------------------------------------
  -- lualine: Status line
  -- ----------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
      },
    },
  },

  -- ----------------------------------------
  -- bufferline: Display buffers as tabs
  -- ----------------------------------------
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory" },
        },
      },
    },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
  },

  -- ----------------------------------------
  -- gitsigns: Git diff display
  -- ----------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
      end,
    },
  },

  -- ----------------------------------------
  -- indent-blankline: Indent guides
  -- ----------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "|" },
      scope = { enabled = true },
      exclude = {
        filetypes = { "dashboard", "help", "neo-tree", "lazy" },
      },
    },
  },

  -- ----------------------------------------
  -- Comment.nvim: Comment toggle
  -- ----------------------------------------
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ----------------------------------------
  -- nvim-autopairs: Auto bracket closing
  -- ----------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- ----------------------------------------
  -- noice.nvim: Modern UI
  -- ----------------------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- ----------------------------------------
  -- dashboard-nvim: Start screen
  -- ----------------------------------------
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "ibhagwan/fzf-lua" },
    opts = {
      theme = "doom",
      config = {
        header = {
          "",
          "",
          "  _____  _    _  __    _    _  ____  ",
          " |_   _|/ \\  | |/ /   / \\  ( )/ ___| ",
          "   | | / _ \\ | ' /   / _ \\ |/ \\___ \\ ",
          "   | |/ ___ \\| . \\  / ___ \\    ___) |",
          "   |_/_/   \\_\\_|\\_\\/_/   \\_\\  |____/ ",
          "",
          "           __     _____ __  __ ",
          "           \\ \\   / /_ _|  \\/  |",
          "            \\ \\ / / | || |\\/| |",
          "             \\ V /  | || |  | |",
          "              \\_/  |___|_|  |_|",
          "",
          "   [ Code with passion, debug with patience ]",
          "",
          "",
        },
        center = {
          { action = function() require("fzf-lua").files() end, desc = "Find file", key = "f" },
          { action = "ene | startinsert", desc = "New file", key = "n" },
          { action = function() require("fzf-lua").oldfiles() end, desc = "Recent files", key = "r" },
          { action = function() require("fzf-lua").live_grep() end, desc = "Find text", key = "g" },
          { action = "Lazy", desc = "Lazy", key = "l" },
          { action = "qa", desc = "Quit", key = "q" },
        },
      },
    },
  },

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

  -- nvim-lspconfig: Provides default LSP settings
  { "neovim/nvim-lspconfig" },

  -- ----------------------------------------
  -- nvim-cmp: Completion engine
  -- ----------------------------------------
  {
    "hrsh7th/nvim-cmp",
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
        python = { "ruff_format" },
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

  -- ----------------------------------------
  -- todo-comments: TODO comment highlighting
  -- ----------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>TodoFzfLua<cr>", desc = "Todo list" },
    },
  },

  -- ----------------------------------------
  -- trouble.nvim: Diagnostic list display
  -- ----------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    },
  },
}

-- ----------------------------------------
-- lazy.nvim initialization
-- ----------------------------------------
require("lazy").setup(plugins, {
  rocks = { enabled = false },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true, notify = false },
})

-- ============================================
-- LSP Settings (Neovim 0.11+ style)
-- ============================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.config("html", {
  filetypes = { "html", "htmldjango" },
})

vim.lsp.enable({
  "pyright", "ruff", "gopls", "lua_ls",
  "html", "cssls", "ts_ls", "jsonls",
})

-- ============================================
-- Django Template Recognition
-- ============================================
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.html"] = "htmldjango",
  },
})

-- ============================================
-- Keymaps
-- ============================================
local map = vim.keymap.set

-- Insert mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- File operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Window operations
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Line movement
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Search
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- LSP keymaps
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- UI toggle
map("n", "<leader>un", "<cmd>set number!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrap" })
