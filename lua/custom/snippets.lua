local luasnip = require("luasnip")
-- local types = require('luasnip.util.types')

-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "./lua/custom/snippets" })

luasnip.filetype_extend("php", { "html" })
luasnip.filetype_extend("php", { "phpdoc" })
-- luasnip.filetype_extend("php", {"blade"})
luasnip.filetype_extend("vue", { "html" })
luasnip.filetype_extend("vue", { "javascript" })
-- luasnip.filetype_extend("blade", {"html"})

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = false,

  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

-- selecting within a list of options
-- useful for choice nodes
-- vim.keymap.set("i", "<c-l>", function()
--     if luasnip.choice_active() then
--         luasnip.change_choice(1)
--     end
-- end)
