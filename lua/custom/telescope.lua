local data = assert(vim.fn.stdpath("data")) --[[@as string]]
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    wrap_results = true,
    history = {
      path = vim.fs.joinpath(data, "telescope_history"),
      limit = 100,
    },
    path_display = { "smart" },
    initial_mode = "insert",
    layout_config = {
      horizontal = {
        width = 0.7,
        height = 0.9,
      },
    },
    file_ignore_patterns = { ".git/", "node_modules", "vendor" },
    preview = true,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-l>"] = actions_layout.toggle_preview,
        ["<C-u>"] = actions.results_scrolling_up,
        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-l>"] = actions_layout.toggle_preview,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,
        ["<C-d>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker

    find_files = {
      path_display = { "smart" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

vim.keymap.set("n", "<C-a>", function()
  builtin.find_files({
    prompt_title = "Find all files",
    hidden = true,
    no_ignore = true,
    find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--exclude", "node_modules", "--exclude", "vendor" },
    follow = false, -- don't follow symlinks
    layout_config = {
      prompt_position = "top",
    },
  })
end)
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files({
    prompt_title = "Find files (untracked + submodules)",
    hidden = true,
    no_ignore = false, -- respect .gitignore but include untracked
    follow = false, -- don't follow symlinks
    layout_config = {
      prompt_position = "top",
    },
  })
end)
vim.keymap.set("n", "<space>gs", builtin.grep_string)
vim.keymap.set("n", "<space>gg", builtin.live_grep)
vim.keymap.set("n", "<space>G", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<space>H", builtin.help_tags)
-- vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
