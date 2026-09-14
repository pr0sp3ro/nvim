return {
  {
    "pr0sp3ro/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
        filetypes = {
          yaml = true,
          markdown = true,
          ["*"] = true,
        },
      })
    end,
  },
  {
    "pr0sp3ro/copilot-cmp",
    dependencies = { "pr0sp3ro/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
