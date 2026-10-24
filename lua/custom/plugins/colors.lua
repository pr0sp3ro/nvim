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
        text = "#d8d8d8",
        keyword = "#aca1cf",
        func = "#ffc799",
        type = "#aca1cf",
        string = "#90b99f",
        constant = "#e6b99d",
        property = "#d8d8d8",
        comment = "#7e7e7e",
        punctuation = "#a0a0a0",
        muted = "#a0a0a0",
        float = "#181818",
        selection = "#34302d",
        border = "#303030",
        error = "#f5a191",
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

      local highlights = {
        Normal = { fg = palette.text, bg = "none" },
        NormalNC = { link = "Normal" },
        NormalFloat = { fg = palette.text, bg = palette.float },
        FloatBorder = { fg = palette.border, bg = palette.float },
        FloatTitle = { fg = palette.func, bg = palette.float, bold = true },
        WinSeparator = { fg = palette.border, bg = "none" },
        LineNr = { fg = palette.comment, bg = "none" },
        CursorLineNr = { fg = palette.func, bg = "none", bold = true },
        CursorLine = { bg = palette.float },
        SignColumn = { bg = "none" },
        EndOfBuffer = { fg = palette.border, bg = "none" },
        Visual = { fg = palette.text, bg = palette.selection },
        Search = { fg = palette.text, bg = palette.selection },
        IncSearch = { fg = "#101010", bg = palette.func },
        CurSearch = { link = "IncSearch" },
        MatchParen = { fg = palette.func, bg = palette.selection, bold = true },
        Pmenu = { link = "NormalFloat" },
        PmenuSel = { fg = palette.func, bg = palette.selection, bold = true },
        PmenuSbar = { bg = palette.float },
        PmenuThumb = { bg = palette.border },
        PmenuMatch = { fg = palette.func, bold = true },
        PmenuMatchSel = { fg = palette.func, bg = palette.selection, bold = true },
        TelescopeNormal = { link = "NormalFloat" },
        TelescopeBorder = { link = "FloatBorder" },
        TelescopeTitle = { link = "FloatTitle" },
        TelescopeSelection = { link = "PmenuSel" },
        TelescopeSelectionCaret = { link = "PmenuSel" },
        TelescopeMatching = { fg = palette.func, bold = true },
        TelescopePromptPrefix = { fg = palette.func, bg = palette.float },
        StatusLine = { fg = palette.text, bg = "none", bold = true },
        StatusLineNC = { fg = palette.muted, bg = "none" },
        TabLine = { fg = palette.muted, bg = "none" },
        TabLineSel = { fg = palette.func, bg = "none", bold = true },
        TabLineFill = { bg = "none" },
        Directory = { fg = palette.func },
        Title = { fg = palette.func, bold = true },
        MoreMsg = { fg = palette.string },
        Question = { fg = palette.func },
        ErrorMsg = { fg = palette.error },
        WarningMsg = { fg = palette.constant },
        Error = { fg = palette.error },
        Todo = { fg = palette.func, bold = true },
        NonText = { fg = palette.border },
        SpecialKey = { fg = palette.comment },
        Folded = { fg = palette.muted, bg = palette.float },
        FoldColumn = { fg = palette.comment, bg = "none" },
        GitSignsAdd = { fg = palette.string },
        GitSignsChange = { fg = palette.constant },
        GitSignsDelete = { fg = palette.error },
        SnippetTabstop = { bg = "none" },
      }
      for group, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, highlight)
      end

      local diagnostics = {
        Error = palette.error,
        Warn = palette.constant,
        Info = palette.type,
        Hint = palette.muted,
        Ok = palette.string,
      }
      for severity, color in pairs(diagnostics) do
        vim.api.nvim_set_hl(0, "Diagnostic" .. severity, { fg = color })
        vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
      end
    end,
  },
}
