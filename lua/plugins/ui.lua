return {
  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "ibhagwan/fzf-lua" },
    opts = {
      theme = "doom",
      config = {
        header = {
          "",
          "   _____  _     _  __     _     _  ____   ",
          "  |_   _|/ \\   | |/ /    / \\   ( )/ ___|  ",
          "    | | / _ \\  | ' /    / _ \\  |/ \\___ \\  ",
          "    | |/ ___ \\ | . \\   / ___ \\    ___) |  ",
          "    |_/_/   \\_\\|_|\\_\\ /_/   \\_\\  |____/   ",
          "",
          "             __     _____ __  __          ",
          "             \\ \\   / /_ _|  \\/  |         ",
          "              \\ \\ / / | || |\\/| |         ",
          "               \\ V /  | || |  | |         ",
          "                \\_/  |___|_|  |_|         ",
          "",
        },
        center = {
          { action = function() require("fzf-lua").files() end,     desc = "Find file",    key = "f" },
          { action = "ene | startinsert",                           desc = "New file",     key = "n" },
          { action = function() require("fzf-lua").oldfiles() end,  desc = "Recent files", key = "r" },
          { action = function() require("fzf-lua").live_grep() end, desc = "Find text",    key = "g" },
          { action = "Lazy",                                        desc = "Lazy",         key = "l" },
          { action = "qa",                                          desc = "Quit",         key = "q" },
        },
      },
    },
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "kanagawa",
      },
    },
  },

  -- Bufferline
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
      { "<leader>bd", "<cmd>bdelete<cr>",             desc = "Delete buffer" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
  },

  -- Noice
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

  -- Indent Blankline
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
}
