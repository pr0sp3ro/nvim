return {
  "j-morano/buffer_manager.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = { "M", "<space>b" },
  config = function()
    local opts = { noremap = true }

    require("buffer_manager").setup({
      select_menu_item_commands = {
        edit = {
          key = "<CR>",
          command = "edit",
        },
        v = {
          key = "<C-v>",
          command = "vsplit",
        },
        h = {
          key = "<C-x>",
          command = "split",
        },
      },
      focus_alternate_buffer = false,
      short_file_names = false,
      short_term_names = true,
      loop_nav = false,
      width = 100,
      height = 20,
    })

    local bmui = require("buffer_manager.ui")

    vim.keymap.set("n", "M", bmui.toggle_quick_menu, opts)
    -- Open menu and search
    vim.keymap.set("n", "<space>b", function()
      bmui.toggle_quick_menu()
      -- wait for the menu to open
      vim.defer_fn(function()
        vim.fn.feedkeys("/")
      end, 50)
    end, opts)

    -- Next/Prev
    -- vim.keymap.set('n', '<space>h', bmui.nav_prev, opts)
    -- vim.keymap.set('n', '<space>l', bmui.nav_next, opts)
  end,
}
