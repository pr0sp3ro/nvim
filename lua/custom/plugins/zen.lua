return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = { "<leader>z" },
  config = function()
    local zenmode = require("zen-mode")

    zenmode.setup({
      window = {
        width = 265,
        height = 60,
        options = {
          -- signcolumn = "no",
          number = true,
          relativenumber = true,
          -- cursorline = true,
          -- cursorcolumn = true,
          -- foldcolumn = "0",
          list = true,
        },
        backdrop = 0.95,
      },
    })

    vim.keymap.set("n", "<leader>z", function()
      zenmode.toggle()

      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
    end)
  end,
}
