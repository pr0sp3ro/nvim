vim.opt_local.commentstring = "// %s"

vim.cmd([[
    command! -buffer FuncSearch execute "/\\%(protected\\|public\\|private\\)\\zs.*function.*"
]])

vim.keymap.set("n", "<leader>/F", ":FuncSearch<CR>", { buffer = true })
vim.keymap.set("n", "<leader>/f", "/fun.*", { buffer = true })
vim.keymap.set("n", "<leader>/c", "/case\\|default.*:$<CR>", { buffer = true })
