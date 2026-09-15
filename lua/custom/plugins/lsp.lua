return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "stevearc/conform.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local extend = function(name, key, values)
        local default = vim.lsp.config[name]
        if not default then
          return values
        end
        local keys = vim.split(key, ".", { plain = true })
        for _, item in ipairs(keys) do
          default = default and default[item]
        end

        if not default then
          return values
        end

        if vim.islist(default) then
          for _, value in ipairs(default) do
            table.insert(values, value)
          end
        else
          for item, value in pairs(default) do
            if not vim.tbl_contains(values, item) then
              values[item] = value
            end
          end
        end
        return values
      end

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local servers = {
        bashls = true,
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
          settings = {
            Lua = {
              diagnostics = {
                globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
              },
            },
          },
        },
        intelephense = {
          init_options = {
            globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
          },
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local dir = vim.fs.dirname(fname)

            local super = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-superproject-working-tree" })[1]

            local root
            if super and super ~= "" then
              root = super
            else
              root = vim.fs.root(bufnr, { "composer.json", ".git" }) or vim.fn.getcwd()
            end

            on_dir(root)
          end,
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
              },
              telemetry = {
                enabled = false,
              },
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "com_dotnet",
                "Core",
                "ctype",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "exif",
                "FFI",
                "fileinfo",
                "filter",
                "fpm",
                "ftp",
                "gd",
                "gettext",
                "gmp",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "meta",
                "mysqli",
                "oci8",
                "odbc",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "posix",
                "pspell",
                "random",
                "readline",
                "Reflection",
                "session",
                "shmop",
                "SimpleXML",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "sqlite3",
                "standard",
                "superglobals",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "Zend OPcache",
                "zip",
                "zlib",
                "redis",
              },
              environment = {
                includePaths = { "." },
              },
            },
          },
        },

        pyright = true,

        -- Enabled biome formatting, turn off all the other ones generally
        biome = true,
        vtsls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              -- schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        taplo = true,

        clangd = {
          -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
          -- TODO: Could include cmd, but not sure those were all relevant flags.
          --    looks like something i would have added while i was floundering
          -- init_options = { clangdFileStatus = true },

          filetypes = { "c" },
        },

        tailwindcss = {
          filetypes = extend("tailwindcss", "filetypes", { "vue" }),
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  [[class: "([^"]*)]],
                  [[className="([^"]*)]],
                },
              },
              -- includeLanguages = extend("tailwindcss", "settings.tailwindCSS.includeLanguages", {
              -- 	["ocaml.mlx"] = "html",
              -- }),
            },
          },
        },

        sqlls = true,
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "stylua",
        "lua_ls",
        "delve",
        "gopls",
        "intelephense",
        "pyright",
        "bashls",
        "shellcheck",
        "hadolint",
        "sqlls",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local builtin = require("telescope.builtin")

          local goto_definition = function()
            local win = vim.api.nvim_get_current_win()

            vim.lsp.buf_request_all(bufnr, "textDocument/definition", function(request_client)
              return vim.lsp.util.make_position_params(win, request_client.offset_encoding)
            end, function(results)
              local definitions = {}

              for client_id, response in pairs(results) do
                if response.err then
                  vim.notify(response.err.message, vim.log.levels.ERROR)
                elseif response.result then
                  local locations = vim.islist(response.result) and response.result or { response.result }
                  local response_client = vim.lsp.get_client_by_id(client_id)

                  if response_client then
                    for _, location in ipairs(locations) do
                      table.insert(definitions, {
                        location = location,
                        position_encoding = response_client.offset_encoding,
                      })
                    end
                  end
                end
              end

              if vim.tbl_isempty(definitions) then
                vim.notify("No definitions found", vim.log.levels.INFO)
                return
              end

              if #definitions == 1 then
                local definition = definitions[1]
                vim.lsp.util.show_document(definition.location, definition.position_encoding, { reuse_win = true })
                return
              end

              vim.ui.select(definitions, {
                prompt = "Select definition",
                format_item = function(definition)
                  local loc = definition.location
                  local uri = loc.uri or loc.targetUri
                  local range = loc.range or loc.targetSelectionRange or loc.targetRange
                  local filename = uri and vim.fs.basename(vim.uri_to_fname(uri)) or "[unknown]"
                  local line = range and (range.start.line + 1) or 0
                  return string.format("%s:%d", filename, line)
                end,
              }, function(definition)
                if definition then
                  vim.lsp.util.show_document(
                    definition.location,
                    definition.position_encoding,
                    { reuse_win = true }
                  )
                end
              end)
            end)
          end

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", goto_definition, { buffer = bufnr })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          -- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          -- vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>c", vim.lsp.buf.code_action, { buffer = 0 })
          -- vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

          vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
          vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
          vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = false, -- if false, diagnostics are updated on InsertLeave
        underline = false,
        severity_sort = false,
        float = {
          focusable = false,
          style = "default",
          border = "rounded",
          source = "if_many",
          header = "Diagnostics",
          prefix = "• ",
        },
      })

      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      --     vim.lsp.handlers.hover, {
      --         border = "rounded",
      --         max_height = 25,
      --         max_width = 100,
      --         focusable = true,
      --         silent = true
      --         -- title = "",
      --     }
      -- )
      --
      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      --     vim.lsp.handlers.signature_help, {
      --         border = "rounded",
      --     }
      -- )

      vim.keymap.set("n", "<space>lr", "<cmd>lsp restart<cr>")
      vim.keymap.set("n", "<space>ld", "<cmd>lsp disable<cr>")
      vim.keymap.set("n", "<space>le", "<cmd>lsp enable<cr>")

      require("custom.autoformat").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      debug = false, -- set to true to enable debug logging
      log_path = "debug_log_file_path", -- debug log path
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false

      doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      -- hint_prefix = " ", -- icon, Panda for parameter
      hint_prefix = "💡 ", -- icon, Panda for parameter
      -- hint_scheme = "Comment",
      hint_scheme = "String",
      use_lspsaga = false, -- set to true if you want to use lspsaga popup
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      -- to view the hiding contents
      max_width = 50, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "rounded", -- double, rounded, single, shadow, none
      },
      always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      check_completion_visible = true, -- adjust position of signature window relative to completion popup
      extra_trigger_chars = { "{", "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      transparency = 100, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = "<C-s>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    },
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      vim.keymap.set("n", "<space>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

      require("outline").setup({
        outline_window = {
          position = "right",
          split_command = nil,
          width = 40,
          relative_width = true,
          auto_close = true,
          auto_jump = true,
          center_on_jump = true,
          show_numbers = true,
          show_relative_numbers = true,
          wrap = false,
          show_cursorline = true,
          hide_cursor = false,
          focus_on_open = true,
          winhl = "",
        },
        keymaps = {
          show_help = "?",
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          peek_location = "o",
          goto_and_close = "<S-Cr>",
          restore_location = "<C-g>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_toggle_all = "<S-Tab>",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
          down_and_jump = "<C-j>",
          up_and_jump = "<C-k>",
        },
      })
    end,
  },
}
