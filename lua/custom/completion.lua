require("custom.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")

local kind_formatter = lspkind.cmp_format({
  mode = "symbol_text",
  menu = {
    buffer = "[buf]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[api]",
    path = "[path]",
    luasnip = "[snip]",
    copilot = "[AI]",
    gh_issues = "[issues]",
  },
})

-- Add tailwindcss-colorizer-cmp as a formatting source
require("tailwindcss-colorizer-cmp").setup({
  color_square_width = 2,
})

local cmp = require("cmp")
local copilot_cmp = require("copilot_cmp.comparators")

cmp.setup({
  sources = {
    { name = "copilot" },
    { name = "luasnip" },
    -- { name = "avante" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
  performance = { fetching_timeout = 2000 },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<CR>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
    ["<c-space>"] = cmp.mapping.complete(),
    ["<C-c>"] = cmp.mapping(function()
      cmp.close()
    end),
  },

  -- Enable luasnip to handle snippet expansion for nvim-cmp
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      -- Lspkind setup for icons
      vim_item = kind_formatter(entry, vim_item)

      -- Tailwind colorizer setup
      vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

      return vim_item
    end,
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      copilot_cmp.prioritize,
      copilot_cmp.score,
      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  -- window = {
  -- 	-- TODO: I don't like this at all for completion window, it takes up way too much space.
  -- 	--  However, I think the docs one could be OK, but I need to fix the highlights for it
  -- 	--
  -- 	-- completion = cmp.config.window.bordered(),
  -- 	-- documentation = cmp.config.window.bordered(),
  -- },
  window = {
    completion = {
      winhighlight = "Normal:NormalFloat,FloatBorder:Pmenu,Search:None",
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    },
    documentation = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
      max_height = 30,
      max_width = 60,
    }),
  },
  experimental = {
    ghost_text = true,
  },
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  enabled = false,
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
