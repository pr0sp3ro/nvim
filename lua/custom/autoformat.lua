local setup = function()
  -- Autoformatting Setup
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      blade = { "blade-formatter" },
      toml = { "taplo" },
    },
  })

  conform.formatters.injected = {
    options = {
      ignore_errors = false,
      lang_to_formatters = {
        sql = { "sleek" },
      },
    },
  }

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
    callback = function(args)
      local ft = vim.bo.filetype
      if ft == "blade" then
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = false,
          quiet = true,
          -- async = true,
        })

        return
      end

      if ft == "c" then
        return
      end

      if ft == "php" then
        return
      end

      require("conform").format({
        bufnr = args.buf,
        lsp_fallback = true,
        quiet = true,
      })
    end,
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
    require("conform").format({ async = true, lsp_fallback = true, range = range })
  end, { range = true })
end

setup()

return { setup = setup }
