return {
  {
    "folke/sidekick.nvim",
    -- Must load at startup: NES is triggered by autocmds, not only by the keymap below
    lazy = false,
    opts = {},
    keys = {
      -- <M-n> is taken by tmux (switch-client -n), so it never reaches Neovim
      {
        "<Tab>",
        function()
          -- Fall back to the regular <Tab> (jumplist forward) when there is no suggestion
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
    },
  },
}
