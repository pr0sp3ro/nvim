local setup = function()
  -- Manual formatting setup
  local conform = require("conform")
  local util = require("conform.util")
  local web = { "biome", "prettier", stop_after_first = true, lsp_format = "never" }
  local prettier = { "prettier", lsp_format = "never" }

  conform.setup({
    default_format_opts = { lsp_format = "fallback" },
    formatters = {
      ["blade-formatter"] = { prepend_args = { "--indent-size", "2" } },
      biome = {
        command = util.find_executable({ "node_modules/.bin/biome" }, ""),
        require_cwd = true,
      },
      prettier = {
        command = util.find_executable({ "node_modules/.bin/prettier" }, ""),
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      blade = { "blade-formatter" },
      toml = { "taplo" },
      javascript = web,
      javascriptreact = web,
      typescript = web,
      typescriptreact = web,
      json = web,
      jsonc = web,
      css = web,
      vue = prettier,
      html = prettier,
      scss = prettier,
      less = prettier,
      yaml = prettier,
      markdown = prettier,
      graphql = prettier,
      astro = prettier,
      svelte = prettier,
    },
  })

  vim.keymap.set("n", "<leader>F", ":Format<CR>")

  vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, end_line:len() },
      }
    end
    conform.format({ async = true, timeout_ms = 5000, range = range })
  end, { range = true })
end

return { setup = setup }
