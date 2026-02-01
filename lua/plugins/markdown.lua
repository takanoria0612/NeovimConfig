return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      file_types = { "markdown", "Avante" },
      -- コードブロックの見た目設定
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      -- 見出し（H1, H2...）のアイコン設定
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      -- ★エラーの原因だった checkbox の custom 設定を削除しました
      -- デフォルトでも十分に綺麗に表示されます
      checkbox = {
        enabled = true,
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
  },
}
