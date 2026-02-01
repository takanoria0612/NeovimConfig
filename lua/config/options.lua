-- ===========================================
-- Basic Settings
-- ============================================
-- Tab and indent settings
vim.opt.expandtab = true -- Insert spaces when pressing Tab
vim.opt.tabstop = 2      -- Tab character display width
vim.opt.softtabstop = 2  -- Number of spaces inserted by Tab key
vim.opt.shiftwidth = 2   -- Number of spaces for auto-indent

-- Leader key settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Line number display
vim.opt.number = true         -- Show absolute line number for current line
vim.opt.relativenumber = true -- Show relative line numbers for other lines

-- Display settings
vim.opt.termguicolors = true -- Enable 24-bit color
vim.opt.signcolumn = "yes"   -- Always show sign column
vim.opt.cursorline = true    -- Highlight cursor line

-- Search settings
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- But distinguish case if uppercase is included

-- Window split behavior
vim.opt.splitbelow = true -- Open new window below when horizontal split
vim.opt.splitright = true -- Open new window to the right when vertical split

-- Persistent undo history
vim.opt.undofile = true

-- Confirm before exiting with unsaved changes
vim.opt.confirm = true
