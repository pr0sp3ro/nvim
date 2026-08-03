local treesitter = require("nvim-treesitter")

local parsers = {
  "php",
  "phpdoc",
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
  "python",
  "regex",
  "sql",
  "css",
  "markdown",
  "markdown_inline",
}

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Tree-sitter highlighting and folds",
  callback = function(args)
    if vim.bo[args.buf].filetype == "html" then
      return
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

    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldenable = false
  end,
})
