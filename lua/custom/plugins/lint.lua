return {
  "mfussenegger/nvim-lint",
  ft = "dockerfile",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = { dockerfile = { "hadolint" } }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("custom-lint", { clear = true }),
      callback = function(args)
        if vim.bo[args.buf].filetype == "dockerfile" and vim.bo[args.buf].buftype == "" then
          vim.api.nvim_buf_call(args.buf, function()
            lint.try_lint()
          end)
        end
      end,
    })

    lint.try_lint()
  end,
}
