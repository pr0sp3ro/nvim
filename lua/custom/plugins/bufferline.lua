return {
  "akinsho/bufferline.nvim",
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,

        -- tab_size = 20,
        max_name_length = 15,
        max_prefix_length = 15,

        tab_position = "top",

        mappings = true,
        mode = "buffers",

        separator_style = { "", "" },
        indicator = { style = "none" },
        -- enforce_regular_tabs = false,
        always_show_bufferline = false,
        custom_filter = function(buf_number)
          local is_empty_unnamed = vim.api.nvim_buf_get_name(buf_number) == ""
            and vim.api.nvim_buf_line_count(buf_number) == 1
            and vim.api.nvim_buf_get_lines(buf_number, 0, 1, false)[1] == ""
            and not vim.bo[buf_number].modified
            and vim.bo[buf_number].buftype == ""

          return not is_empty_unnamed
        end,
      },
    })

    vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>")
    vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>")
    vim.keymap.set("n", "<c-n>", "<cmd>BufferLineMovePrev<cr>")
    vim.keymap.set("n", "<c-m>", "<cmd>BufferLineMoveNext<cr>")
  end,
}
