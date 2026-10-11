local opt = vim.opt
local cmd = vim.cmd

cmd("set modifiable")
opt.backup = false -- creates a backup file
opt.swapfile = false -- creates a swapfile
opt.undofile = true -- persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.writebackup = true -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- insert x spaces for a tab
opt.softtabstop = -1
opt.expandtab = true -- convert tabs to spaces
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.isfname:append("@-@")
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- override the 'ignorecase' option if the search pattern contains upper case characters
opt.updatetime = 100 -- faster completion (4000ms default)
opt.cmdheight = 1 -- command line messages statusline
opt.clipboard = "unnamedplus"
opt.fileencoding = "utf-8"
opt.showmode = true -- things like -- INSERT --
opt.showcmd = true -- https://vi.stackexchange.com/questions/742/showing-command-history-with-showcmd
opt.laststatus = 3 -- the value of this option influences when the last window will have a statusline
opt.numberwidth = 4 -- default is 4
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.guifont = "monospace:h11" -- the font used in graphical neovim applications
opt.autoindent = true
opt.smartindent = true
opt.showtabline = 2 -- always show tabline (needed for bufferline)
opt.pumheight = 10 -- maximum number of items to show in the popup menu
-- opt.conceallevel = 1 -- example: make `` visible in markdown files
opt.fillchars = { eob = "~" }
opt.mouse = "a"
opt.mousemodel = "extend"
opt.mousescroll = "ver:8"
opt.inccommand = "split"
-- opt.exrc = true
-- opt.secure = true
-- opt.shortmess:append("c")
-- opt.iskeyword:append(".")
opt.statusline = "%f %m%r [%{&filetype}] %{&fileencoding} %{&fileformat} %p%% %l:%c [%{tabpagenr()}/%{tabpagenr('$')}]"
-- opt.statusline = "%f %m%r [ft: %{&filetype}] [enc: %{&fileencoding}] [ff: %{&fileformat}] [loc: %p%% %l:%c]"
