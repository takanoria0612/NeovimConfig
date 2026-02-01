return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>",         desc = "New Obsidian Note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>",      desc = "Search Obsidian Text" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<cr>",   desc = "Switch Workspace" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch (Find File)" },
    { "<leader>oD", "<cmd>ObsidianToday<cr>",       desc = "Today's Note" },
    { "<leader>ot", "<cmd>ObsidianTemplate<cr>",    desc = "Insert Template" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",   desc = "Show Backlinks" },
    -- Change working directory to the active vault root
    {
      "<leader>oc",
      function()
        local client = require("obsidian").get_client()
        if client and client.dir then
          vim.cmd("tcd " .. tostring(client.dir))
          print("Changed directory to: " .. tostring(client.dir))
        else
          print("Obsidian vault not found")
        end
      end,
      desc = "CD to Obsidian Vault",
    },
  },
  opts = {
    -- Set OBSIDIAN_VAULT env var in your shell config (e.g. ~/.zshrc)
    -- export OBSIDIAN_VAULT="$HOME/path/to/your/vault"
    workspaces = {
      {
        name = "workshop",
        path = vim.fn.expand(os.getenv("OBSIDIAN_VAULT") or ""),
      },
    },
    disable_frontmatter = false,
    -- Frontmatter with PARA method fields (area, project)
    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end

      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        area = "",
        project = "",
      }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    -- Zettelkasten-style ID: YYYYMMDDHHmm-slugified-title
    note_id_func = function(title)
      local id = os.date("%Y%m%d%H%M")
      if title ~= nil then
        local suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        return id .. "-" .. suffix
      else
        return id
      end
    end,
    daily_notes = {
      folder = "Daily",
      date_format = "%Y-%m-%d",
      template = nil,
    },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },
    -- Buffer-local keymaps (only active inside vault files)
    mappings = {
      ["<leader>of"] = {
        action = function() return require("obsidian").util.gf_passthrough() end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>od"] = {
        action = function() return require("obsidian").util.toggle_checkbox() end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function() return require("obsidian").util.smart_action() end,
        opts = { buffer = true, expr = true },
      },
    },
    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      },
      external_link_icon = { char = "", hl_group = "ObsidianExtLink" },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    picker = {
      name = "fzf-lua",
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    vim.opt.conceallevel = 2
  end,
}
