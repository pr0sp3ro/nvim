return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<space>m",
      "<cmd>RenderMarkdown toggle<cr>",
      ft = "markdown",
      desc = "Toggle Markdown rendering",
    },
  },
  -- Backgrounds clash with the colorscheme, so only foreground colors are kept
  opts = {
    heading = {
      backgrounds = {},
    },
    code = {
      disable_background = true,
      highlight_border = false,
      highlight_inline = "@markup.raw",
    },
  },
}
