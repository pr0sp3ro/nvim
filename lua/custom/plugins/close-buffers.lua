return {
  "kazhala/close-buffers.nvim",
  keys = { "<space>dd", "<space>df", "<space>do", "<space>da" },
  config = function()
    local close_buffers = require("close_buffers")

    close_buffers.setup({
      preserve_window_layout = { "this" },
      next_buffer_cmd = function(windows)
        local ok, bufferline = pcall(require, "bufferline")

        if ok then
          bufferline.cycle(1)
        else
          vim.cmd("bnext")
        end

        local bufnr = vim.api.nvim_get_current_buf()

        for _, window in ipairs(windows) do
          if vim.api.nvim_win_is_valid(window) then
            vim.api.nvim_win_set_buf(window, bufnr)
          end
        end
      end,
    })

    vim.keymap.set("n", "<space>dd", function()
      close_buffers.delete({ type = "this" })
    end, { silent = true })

    vim.keymap.set("n", "<space>df", function()
      close_buffers.delete({ type = "this", force = true })
    end, { silent = true })

    vim.keymap.set("n", "<space>do", function()
      close_buffers.delete({ type = "other" })
    end, { silent = true })

    vim.keymap.set("n", "<space>da", function()
      close_buffers.delete({ type = "all" })
    end, { silent = true })
  end,
}
