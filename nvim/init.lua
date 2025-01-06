-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ 
    "git", 
    "clone", 
    "--filter=blob:none", 
    "--branch=stable", 
    lazyrepo, 
    lazypath 
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"          -- This is the default

-- Basic editor options
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = false       -- Show relative line numbers
vim.opt.colorcolumn = "80"           -- Highlight column 80
vim.opt.clipboard = "unnamed"        -- Use system clipboard  
vim.opt.cursorline = true            -- Highlight current line

-- Indentation settings
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.shiftwidth = 4               -- Size of an indent
vim.opt.tabstop = 4                  -- Number of spaces tabs count for
vim.opt.smartindent = true           -- Insert indents automatically
vim.opt.shiftround = true            -- Round indent to multiple of shiftwidth
vim.opt.autoindent = true            -- Copy indent from current line when starting a new line

-- Visual settings
vim.opt.termguicolors = true         -- Enable 24-bit RGB colors
vim.opt.wrap = false                 -- Don't wrap lines

-- System settings
vim.opt.backup = false               -- Don't create backup files
vim.opt.writebackup = false          -- Don't create backup files
vim.opt.swapfile = false             -- Don't create swap files
vim.opt.undofile = true              -- Enable persistent undo
vim.opt.clipboard = "unnamedplus"    -- Use system clipboard

-- Performance settings
vim.opt.updatetime = 300             -- Reduce updatetime to 300ms

-- Split settings
vim.opt.splitbelow = true            -- Put new windows below current

-- Search and replace settings
vim.opt.ignorecase = true            -- Ignore case when searching
vim.opt.smartcase = true             -- Override 'ignorecase' if search contains uppercase characters
vim.opt.incsearch = true             -- Show search matches as you type
vim.opt.hlsearch = false             -- Highlight search matches
vim.opt.gdefault = true              -- Use 'g' flag by default with :s

-- nextra settings
vim.g.loaded_netrw = 1              -- Disable netrw
vim.g.loaded_netrwPlugin = 1        -- Disable netrw

-- Use ripgrep for grepping
vim.opt.grepprg = "rg --vimgrep --smart-case --follow"

-- -- Filetype-specific indentation settings
vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

-- Window splitting
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically', silent = true })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally', silent = true })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size', silent = true })
vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = 'Close current split', silent = true })

-- Window navigation
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = 'Navigate to left split', silent = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = 'Navigate to bottom split', silent = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = 'Navigate to top split', silent = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = 'Navigate to right split', silent = true })

-- Window resizing
vim.keymap.set('n', '<leader>>', '10<C-w>>', { desc = 'Increase width', silent = true })
vim.keymap.set('n', '<leader><', '10<C-w><', { desc = 'Decrease width', silent = true })
vim.keymap.set('n', '<leader>+', '10<C-w>+', { desc = 'Increase height', silent = true })
vim.keymap.set('n', '<leader>-', '10<C-w>-', { desc = 'Decrease height', silent = true })

-- Max out the height of the current split
vim.keymap.set('n', '<leader>sm', '<C-w>_', { desc = 'Max out the height', silent = true })

-- Max out the width of the current split
vim.keymap.set('n', '<leader>sw', '<C-w>|', { desc = 'Max out the width', silent = true })

-- JavaScript/TypeScript/HTML settings (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeIndent",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "lua", "gohtmltmpl" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
  -- Telescope fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Optional: native sorter to improve performance
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      -- Optional: add file browser extension
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = false, -- Clear prompt
              ["<C-w>"] = false  -- Clear prompt word
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "%.git/",
            "%.DS_Store",
            "target/",
            "build/",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip"
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- Additional find_files specific configuration
          },
          live_grep = {
            -- Additional live_grep specific configuration
            additional_args = function()
              return { "--hidden" }
            end
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            -- Additional buffers specific configuration
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            -- theme = "ivy",
            hijack_netrw = true,
            mappings = {
              i = {
                ["<C-h>"] = false,
              },
            },
          },
        }
      })

      -- Load extensions
      telescope.load_extension('fzf')
      -- telescope.load_extension('file_browser')

      -- Keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fo', builtin.lsp_document_symbols, { desc = 'Find lsp symbols' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
      vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'Search in buffer' })
      vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Command history' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
      vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Find marks' })
      vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Find treesitter symbols' })
      -- File browser
      -- vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<CR>', { noremap = true, desc = 'File browser' })
    end,
  },

  -- Gruvbox Theme
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
  },

  -- Tmux integration
  { 
    'alexghergh/nvim-tmux-navigation', 
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  },

  -- Copilot chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      mappings = {
        reset = {
          normal ='<C-x>',
          insert = '<C-x>'
        },
      }
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CopilotChatToggle<cr>",
        desc = "Toggle Copilot Chat",
        mode = "n",
      },
    }
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", vim_item.kind)

            -- Source
            vim_item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })
    end
  },

  -- Copilot completions
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },  

  -- LSP Configuration for Go
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('lspconfig').gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- Global mappings.
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
      })
    end
  },

  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
    config = function()
      -- Highlighting settings
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1

      -- Build/test settings
      vim.g.go_test_timeout = '10s'

      -- Configure key mappings
      local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then
          options = vim.tbl_extend("force", options, opts)
        end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
      end

      -- Common vim-go commands
      map('n', '<leader>gr', ':GoRun<CR>')
      map('n', '<leader>gt', ':GoTest<CR>')
      map('n', '<leader>gb', ':GoBuild<CR>')
      map('n', '<leader>gc', ':GoCoverageToggle<CR>')
      map('n', '<leader>gi', ':GoInfo<CR>')
      map('n', '<leader>gm', ':GoMetaLinter<CR>')
    end,
    dependencies = {
      "neovim/nvim-lspconfig",  -- Optional: if you're using LSP
    }
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "lua", "vim", "vimdoc", "javascript", "typescript", "python",
          "cpp", "c", "rust", "markdown", "bash", "go", "json", "yaml",
          "clojure"
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation
        indent = { enable = true },

        -- Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- Vim-pencil for better writing experience
  {
    "preservim/vim-pencil",
    config = function()
      vim.g['pencil#wrapModeDefault'] = 'soft'   -- default is 'hard'

      -- Create an augroup for pencil
      vim.api.nvim_create_augroup("pencil", { clear = true })

      -- Auto-enable pencil for markdown and text files
      vim.api.nvim_create_autocmd("FileType", {
        group = "pencil",
        pattern = {"markdown", "mkd", "text", "gmi"},
        callback = function()
          vim.cmd([[PencilSoft]])  -- Use soft line wrapping

          -- Optional: Enable spellcheck
          vim.opt_local.spell = true
          vim.opt_local.spelllang = "en_us"

          -- Optional: Set textwidth for automatic wrapping
          vim.opt_local.textwidth = 80
        end,
      })

      -- Key mappings for pencil modes
      vim.keymap.set('n', '<leader>ps', ':PencilSoft<CR>', { silent = true })
      vim.keymap.set('n', '<leader>ph', ':PencilHard<CR>', { silent = true })
      vim.keymap.set('n', '<leader>pt', ':PencilToggle<CR>', { silent = true })
    end,
  },

  -- nvim-tree file browser
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { silent = true })

    end,
  },

  -- Lualine for status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, 
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox-material',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,         
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        -- Inactive windows status line
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        -- Additional options for specific filetypes
        extensions = {'fugitive', 'nvim-tree', 'quickfix'}
      })
    end,
  },

  -- vim-sexp for Lisp editing
  {
    'guns/vim-sexp',
    ft = { 'lisp', 'scheme', 'clojure' },
    dependencies = {
      'tpope/vim-sexp-mappings-for-regular-people',
    },
    config = function()
      vim.g.vimsexp_maps = 0
    end,
  },

  -- Conjure for Clojure development
  {
    'Olical/conjure',
    ft = 'clojure',
    lazy = true,
    config = function()
    --   vim.g.conjure#client#clojure#nrepl#lein#executable = 'lein'
    --   vim.g.conjure#client#clojure#nrepl#lein#command = 'repl :headless'
    --   vim.g.conjure#client#clojure#nrepl#lein#classpath = 'dev'
    --   vim.g.conjure#client#clojure#nrepl#lein#dependencies = 'nrepl'
    --   vim.g.conjure#client#clojure#nrepl#lein#repl_host = 'localhost'
    --   vim.g.conjure#client#clojure#nrepl#lein#repl_port = 5555
    end,
    dependencies = { "PaterJason/cmp-conjure" }
  },

  {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },

  -- Check for updates
  checker = { enabled = true },
})
