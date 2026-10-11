return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    name = "gruvbox",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = false,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })

      vim.cmd.colorscheme("gruvbox")

      -- local g = vim.g
      -- g.transparent_background = true
      -- g.italic_comments = true
      -- g.italic_keywords = true
      -- g.italic_functions = true
      -- g.italic_variables = true
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -- vim.cmd.highlight("StatusLine guifg=#010101 guibg=white ctermbg=NONE")
    end,
  },
  {
    "tjdevries/colorbuddy.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbuddy")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.cmd.highlight("TelescopeSelection guifg=#ffffff guibg=#111111")
      vim.cmd.highlight("TelescopeMatching guifg=#456789")
      vim.cmd.highlight("StatusLine guifg=#ffffff guibg=NONE ctermbg=NONE gui=bold cterm=bold")
      vim.cmd.highlight("StatusLineNC guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.cmd.highlight("TabLine guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.cmd.highlight("TabLineFill guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "none" })
    end,
  },
}
