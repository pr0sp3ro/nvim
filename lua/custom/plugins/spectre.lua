return {
  "nvim-pack/nvim-spectre",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    "<space>S",
    "<space>sf",
    { "<space>sw", mode = { "n", "v" } },
  },
  config = function()
    require("custom.spectre")
  end,
}
