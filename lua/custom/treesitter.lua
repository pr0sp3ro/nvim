local treesitter = require("nvim-treesitter")

local parsers = {
  "php",
  "php_only",
  "phpdoc",
  "html",
  "html_tags",
  "bash",
  "blade",
  "c",
  "cpp",
  "cmake",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "http",
  "jq",
  "json",
  "json5",
  "make",
  "lua",
  "luadoc",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "toml",
  "diff",
  "rust",
  "javascript",
  "typescript",
  "vue",
  "python",
  "regex",
  "sql",
  "css",
  "markdown",
  "markdown_inline",
}

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Tree-sitter highlighting",
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype

    if filetype == "html" then
      return
    end

    -- Dotenv files use Bash grammar for highlighting only. Their filetype stays
    -- `env`, so bashls does not attach and report shell-specific diagnostics.
    local language = filetype == "env" and "bash" or nil

    -- PHP's built-in indentexpr (GetPhpIndent) relies on Vim syntax groups.
    -- Keep regex syntax enabled alongside Tree-sitter, as the old
    -- nvim-treesitter configuration did with additional_vim_regex_highlighting.
    if filetype == "php" then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == "php" then
          vim.cmd("syntax on")
          vim.bo[args.buf].syntax = "php"
        end
      end)
    end

    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.notify(
        "File larger than 100KB; Tree-sitter disabled for performance",
        vim.log.levels.WARN,
        { title = "Treesitter" }
      )
      return
    end

    if not pcall(vim.treesitter.start, args.buf, language) then
      return
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  desc = "Configure folding for the current buffer and window",
  callback = function(args)
    if vim.api.nvim_get_current_buf() ~= args.buf or vim.wo.diff then
      return
    end

    local language = vim.bo[args.buf].filetype == "env" and "bash" or nil
    local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
    local available = vim.bo[args.buf].buftype == "" and not (stats and stats.size > 100 * 1024)
    local ok, parser
    if available then
      ok, parser = pcall(vim.treesitter.get_parser, args.buf, language)
    end

    if ok and parser and vim.treesitter.query.get(parser:lang(), "folds") then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.wo.foldmethod = "manual"
      vim.wo.foldexpr = "0"
    end
  end,
})

local function can_save_view(buf)
  return vim.api.nvim_get_current_buf() == buf
    and vim.bo[buf].buftype == ""
    and vim.bo[buf].buflisted
    and not vim.wo.diff
    and vim.fn.filereadable(vim.api.nvim_buf_get_name(buf)) == 1
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Restore folds and cursor after configuring folding",
  callback = function(args)
    if can_save_view(args.buf) then
      vim.cmd("silent! loadview")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave", "VimLeavePre" }, {
  desc = "Save folds and cursor for regular files",
  callback = function(args)
    if can_save_view(args.buf) then
      vim.fn.mkdir(vim.o.viewdir, "p")
      vim.cmd("silent! mkview!")
    end
  end,
})
