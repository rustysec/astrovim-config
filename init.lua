local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true,
      expandtab = true,
      shiftwidth = 4,
      tabstop = 4,
      cursorline = true,
      number = true,
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      {
        'simrat39/rust-tools.nvim',
        requires = { "Comment.nvim" }
      },
      'machakann/vim-sandwich',
      {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
          require'hop'.setup {}
        end
      },
      ["max397574/better-escape.nvim"] = { disable = true },
      -- ["goolord/alpha-nvim"] = { disable = true },
    },

    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },

    bufferline = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- diagnostics = "nvim_lsp",
      }
    },

    cinnamon = {
      -- KEYMAPS:
      default_keymaps = true,   -- Create default keymaps.
      extra_keymaps = true,     -- Create extra keymaps.
      extended_keymaps = true,  -- Create extended keymaps.
      override_keymaps = false,  -- The plugin keymaps will override any existing keymaps.

      -- OPTIONS:
      always_scroll = false,    -- Scroll the cursor even when the window hasn't scrolled.
      centered = true,          -- Keep cursor centered in window when using window scrolling.
      default_delay = 5,        -- The default delay (in ms) between each line when scrolling.
      hide_cursor = false,      -- Hide the cursor while scrolling. Requires enabling termguicolors!
      horizontal_scroll = false,-- Enable smooth horizontal scrolling when view shifts left or right.
      max_length = -1,          -- Maximum length (in ms) of a command. The line delay will be
                                -- re-calculated. Setting to -1 will disable this option.
      scroll_limit = 150,       -- Max number of lines moved before scrolling is skipped. Setting
                                -- to -1 will disable this option.
    },

    aerial = {
      default_keybinds = false,
      on_attach = function()
        -- do nothing?
      end,
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,
    server_registration = function(server, opts)
      if server == "rust_analyzer" then
        require("rust-tools").setup {
          server = {
              settings = {
                  [ "rust-analyzer" ] = {
                      diagnostics = {
                          enable = true,
                          disabled = { "inactive-code", "unresolved-proc-macro", "unlinked-file", "macro-error" },
                          enableExperimental = true,
                      },
                      cargo = {
                          -- target = "aarch64-apple-darwin",
                          -- target = "x86_64-pc-windows-gnu",
                          -- target = "x86_64-unknown-linux-musl",
                      },
                      checkOnSave = {
                          command = "clippy"
                      }
                  },
              }
          },
        }
      else
        require("lspconfig")[server].setup(opts)
      end
    end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
      ["<leader>V"] = { ":vsplit<cr>", desc = "Vertical split" },
      ["<leader>H"] = { ":split<cr>", desc = "Horizontal split" },
      ["<leader>bo"] = { '<cmd>%bdelete|edit#|bdelete#|normal `"<cr>', desc = "Close other buffers" },
      ["<esc>"] = { ':noh<return><esc>', desc = "Esc" },
      ["gd"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Definition" },
      ["gr"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = "Definition" },
      ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
      ["<leader>ss"] = { "<cmd>:HopPattern<CR>", desc = "Hop to pattern" },
      ["<leader>sc"] = { "<cmd>:HopChar1<CR>", desc = "Hop to character" },
      ["<leader>st"] = { "<cmd>:HopChar2<CR>", desc = "Hop to 2 characters" },
      ["<leader>lr"] = { function() require("telescope.builtin").lsp_references() end, desc = "Search references" },
      ["<leader>ld"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
      -- ['n'] = { "<cmd>lua Scroll('n', 1)<CR>", desc = "Smooth next match" },
      -- ['T'] = { "<cmd>lua Scroll('{', 1)<CR>", desc = "Smooth previous paragraph" },
      -- ['t'] = { "<cmd>lua Scroll('}', 1)<CR>", desc = "Smooth next paragraph" },
      -- ['gg'] = { "<cmd>lua Scroll('gg', 1)<CR>", desc = "Top of buffer" },
      -- ['G'] = { "<cmd>lua Scroll('G', 0, 1)<CR>", desc = "Bottom of buffer" },
      -- ['g#'] = { "<cmd>lua Scroll('g#', 1)<CR>", desc = "Go to" },
      -- ['g*'] = { "<cmd>lua Scroll('g*', 1)<CR>", desc = "Go to" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- local map = vim.keymap.set

    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })
    vim.api.nvim_create_augroup("YankHighlight", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight yanked text",
      group = "YankHighlight",
      pattern = "*",
      command = "silent! lua vim.highlight.on_yank()",
    })
    vim.api.nvim_create_augroup("auto_format", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Auto Format on save",
      group = "auto_format",
      pattern = {"*.rs","*.js","*.json","*.toml","*.go"},
      command = "lua vim.lsp.buf.formatting_sync()",
    })
    vim.cmd("runtime macros/sandwich/keymap/surround.vim")

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
