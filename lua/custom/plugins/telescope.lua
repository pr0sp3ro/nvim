return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = { "<C-a>", "<C-p>", "<space>gs", "<space>gg", "<space>G", "<space>H" },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("custom.telescope")
  end,
}
