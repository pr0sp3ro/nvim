local lir = require'lir'
local actions = require'lir.actions'
-- local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'
local git_status = require'lir.git_status'

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_keymap("n", "<leader>e", ":lua require'lir.float'.toggle()<cr>", { noremap = true, silent = true })

git_status.setup({
    show_ignored = false
})

vim.cmd[[
    highlight link LirGitStatusBracket Comment
    highlight link LirGitStatusIndex Special
    highlight link LirGitStatusWorktree WarningMsg
    highlight link LirGitStatusUnmerged ErrorMsg
    highlight link LirGitStatusUntracked Comment
    highlight link LirGitStatusIgnored Comment
]]

lir.setup {
    show_hidden_files = true,
    devicons = {
        enable = true,
        highlight_dirname = false
    },
    mappings = {
        ['l']      = actions.edit,
        ['<cr>']   = actions.edit,
        ['o']      = actions.edit,
        ['<c-s>']      = actions.split,
        ['<c-x>']      = actions.vsplit,
        -- ['x']      = actions.tabedit,

        ['h']      = actions.up,
        ['q']      = actions.quit,
        ['<esc>']  = actions.quit,

        ['md']     = actions.mkdir,
        ['mf']     = actions.newfile,
        ['r']      = actions.rename,
        ['@']      = actions.cd,
        ['Y']      = actions.yank_path,
        ['.']      = actions.toggle_show_hidden,
        ['dd']     = actions.delete,

        -- ['J'] = function()
        --   mark_actions.toggle_mark()
        --   vim.cmd('normal! j')
        -- end,
        ['y'] = clipboard_actions.copy,
        ['x'] = clipboard_actions.cut,
        ['p'] = clipboard_actions.paste,
    },
    float = {
        winblend = 0,
        curdir_window = {
            enable = true,
            highlight_dirname = true
        },
        -- You can define a function that returns a table to be passed as the third
        -- argument of nvim_open_win().
        win_opts = function()
            local width = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines * 0.7)
            return {
                border = "rounded",
                width = width,
                height = height,
                -- row = 1,
                -- col = math.floor((vim.o.columns - width) / 2),
            }
        end,
    },
    hide_cursor = false,
    on_init = function()
        -- Use visual mode
        -- vim.api.nvim_buf_set_keymap(
        --   0,
        --   "x",
        --   "J",
        --   ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        --   { noremap = true, silent = true }
        -- )

        vim.opt.relativenumber = true
        -- echo cwd
        vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
    end,
}

-- Custom folder icon
require'nvim-web-devicons'.set_icon({
    lir_folder_icon = {
        icon = "???",
        color = "#7ebae4",
        name = "LirFolderNode"
    }
})

