local set = vim.keymap.set
local cmd = vim.cmd
local g = vim.g

-- set("n", "<space>tt", function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
-- end)
-- vim.cmd[[ nnoremap <expr><silent> <leader>, &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>" ]]

set("n", "<leader>q", "ZQ")
set("n", "<leader>Q", ":w<CR>:qall<CR>")
set("n", "<leader>w", ":w<CR>")
cmd("command! SaveAsRoot :execute ':silent w !sudo tee % > /dev/null' | :edit!")
cmd("nmap <leader>W :SaveAsRoot<CR>")

set("n", "Y", "y$")
set("v", "p", '"_dP')

set("n", "<leader>r", "VP==")
-- set("n", "<leader>C", "v$hP")
set("n", "<leader>p", "o<esc>p==")
set("n", "<leader>P", "O<esc>P==")
-- set("n", "<leader>Y", "v$hy")
-- set("n", "<leader>d", "\"_d")
-- set("v", "<leader>d", "\"_d")

-- set("x", "<leader>p", "\"_dP")
-- set("n", "<leader>y", "\"+y")
-- set("v", "<leader>y", "\"+y")
-- set("n", "<leader>Y", "\"+Y")
-- set("n", "<leader>d", "\"_d")
-- set("v", "<leader>d", "\"_d")

set("n", "Q", "gq")
set("n", "Q", "<nop>")

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "J", "mzJ`z")
-- set("n", "<C-d>", "<C-d>zz")
-- set("n", "<C-u>", "<C-u>zz")
set("v", ".", ":normal .<CR>")
set("v", "<", "<gv")
set("v", ">", ">gv")
set("n", "<leader>k", "Vypk$")
set("n", "<leader>j", "VyPj$")
set("v", "J", ":m '>+1<CR>gv=gv")
set("x", "J", ":move '>+1<CR>gv-gv")
set("v", "K", ":m '<-2<CR>gv=gv")
set("x", "K", ":move '<-2<CR>gv-gv")

-- set("n", "gch", "I<!-- <esc>A --><esc>0")
-- set("n", "gcj", "I// <esc>")
-- set("n", "gcaj", "vapk<c-v>I// <esc>")
-- set("v", "gcj", "^<C-v>I// <esc>")
-- set("n", "gcH", "0df $daw0")
-- set("n", "gcp", "I// <esc>0")
-- set("n", "gcP", "0df ")

set("n", "<leader><leader>sw", ":set wrap<CR>:set linebreak<CR>")
set("n", "<leader><leader>fh", ":set filetype=html<CR>")
set("n", "<leader><leader>fp", ":set filetype=php<CR>")
set("n", "<leader><leader>fc", ":set filetype=c<CR>")
set("n", "<leader><leader>f", ":retab! 4<CR>")

set("n", "2o", "o<esc>o")
set("n", "2O", "O<esc>O")
set("n", "g;", "A;<esc>")
-- set("n", "H", "^")
-- set("v", "H", "^")
-- set("n", "L", "$h")
set("v", "$", "$h")
-- set("v", "L", "$h")

-- set("i", "<C-h>", "<C-o>^")
-- set("i", "<C-l>", "<C-o>$")
-- set('i', ';', '<Esc>A;')
-- set('i', '<M-;>', ';')

set("n", "<leader>v", ":vsplit<CR>")
set("n", "<leader>x", ":split<CR>")
-- set("n", "<leader>K", "<c-w>_ | <c-w>|")
-- set("n", "<leader>J", "<c-w>=")

-- set("n", "<C-b>", "i**<esc>ea**<esc>B")
-- set("n", "da*", "xxwxxB")

set("n", "vv", "^v$h")
set("n", "gC", "ggcG")
set("n", "gy", "ggVGy<c-o>")

-- set("n", "<leader>Zi", ":set foldmethod=indent<CR>")
-- set("n", "<leader>Ze", ":set foldmethod=expr<CR>")

set("n", "<leader>tn", ":tabnew<CR>")
set("n", "<leader>td", ":tabclose<CR>")
set("n", "<leader>>", ":tabmove +<CR>")
set("n", "<leader><", ":tabmove -<CR>")
set("n", "=G", "gg=G")
set("n", "yG", "ggyG")
set("n", "<leader>'", ":%s/\"/'/g<CR>")
set("n", '<leader>"', ":%s/'/\"/g<CR>")

set("n", "{", "5k")
set("n", "}", "5j")
