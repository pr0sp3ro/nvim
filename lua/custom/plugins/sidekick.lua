return {
  {
    "folke/sidekick.nvim",
    -- Must load at startup: NES is triggered by autocmds, not only by the keymap below
    lazy = false,
    opts = {},
    keys = {
      {
        "<M-n>",
        function()
          require("sidekick").nes_jump_or_apply()
        end,
        desc = "Goto/Apply Next Edit Suggestion",
      },
    },
  },
}
