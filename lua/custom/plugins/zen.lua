return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = { "<leader>z" },
  config = function()
    local zenmode = require("zen-mode")

    zenmode.setup({
      window = {
        width = 0.8,
        height = 0.9,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          list = false,
        },
        backdrop = 0.95,
      },
      plugins = {
        options = {
          laststatus = 0,
        },
        diagnostics = { enabled = true },
      },
    })

    vim.keymap.set("n", "<leader>z", function()
      zenmode.toggle()

      vim.wo.wrap = false
    end)
  end,
}
