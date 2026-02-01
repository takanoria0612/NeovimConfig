-- ============================================
-- 1. Load Core Settings
-- ============================================
require("config.options")
require("config.keymaps")

-- ============================================
-- 2. lazy.nvim Bootstrap
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
-- 3. Load All Plugins
-- ============================================
require("lazy").setup({
  spec = {
    -- lua/plugins フォルダ内の全てのファイルを自動的に読み込む
    { import = "plugins" },
  },
  rocks = { enabled = false },
  install = { colorscheme = { "kanagawa" } },
  checker = { enabled = true, notify = false },
})
