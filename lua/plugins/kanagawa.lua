return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    -- Kanagawaの設定
    require('kanagawa').setup({
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      transparent = false,
    })
    vim.cmd("colorscheme kanagawa")
  end,
}
