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
      local palette = {
        text = "#E6EDF3",
        keyword = "#C792EA",
        func = "#8ABEFF",
        type = "#78DCCA",
        string = "#9DDFB5",
        constant = "#F78C6C",
        property = "#FFCB6B",
        comment = "#929DB0",
        punctuation = "#B8C4D4",
      }
      local syntax = {
        {
          palette.keyword,
          {
            "Statement",
            "Conditional",
            "Repeat",
            "Label",
            "Keyword",
            "Exception",
            "Include",
            "Define",
            "PreProc",
            "StorageClass",
            "@keyword",
          },
        },
        {
          palette.func,
          {
            "Function",
            "@function",
            "@function.call",
            "@function.builtin",
            "@function.method",
            "@function.method.call",
            "@constructor",
            "@attribute",
          },
        },
        {
          palette.type,
          { "Type", "Structure", "Typedef", "@type", "@type.builtin", "@type.definition", "@module", "@tag" },
        },
        { palette.string, { "String", "Character", "@string", "@string.escape", "@string.regexp", "@character" } },
        {
          palette.constant,
          { "Constant", "Number", "Boolean", "Float", "@constant", "@constant.builtin", "@number", "@boolean" },
        },
        { palette.text, { "Identifier", "@variable", "@variable.builtin", "@variable.parameter" } },
        { palette.property, { "@property", "@variable.member", "@tag.attribute" } },
        { palette.punctuation, { "Operator", "Delimiter", "@operator", "@punctuation", "@tag.delimiter" } },
      }
      for _, entry in ipairs(syntax) do
        for _, group in ipairs(entry[2]) do
          vim.api.nvim_set_hl(0, group, { fg = entry[1] })
        end
      end
      vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment, italic = true })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

      local semantic = {
        namespace = "@module",
        class = "@type",
        interface = "@type",
        struct = "@type",
        enum = "@type",
        type = "@type",
        typeParameter = "@type",
        ["function"] = "@function",
        method = "@function.method",
        decorator = "@attribute",
        property = "@property",
        parameter = "@variable.parameter",
        variable = "@variable",
        enumMember = "@constant",
        keyword = "@keyword",
        string = "@string",
        number = "@number",
        operator = "@operator",
        comment = "@comment",
      }
      for token, group in pairs(semantic) do
        vim.api.nvim_set_hl(0, "@lsp.type." .. token, { link = group })
      end

      vim.api.nvim_set_hl(0, "Normal", { fg = palette.text, bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = palette.text, bg = "none", bold = true })
      vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = palette.func, bold = true })
      vim.cmd.highlight("StatusLine guifg=#ffffff guibg=NONE ctermbg=NONE gui=bold cterm=bold")
      vim.cmd.highlight("StatusLineNC guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.cmd.highlight("TabLine guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.cmd.highlight("TabLineFill guifg=#ffffff guibg=NONE ctermbg=NONE")
      vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "none" })
    end,
  },
}
