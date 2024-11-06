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
vim.opt.signcolumn = "yes"           -- Always show the signcolumn
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

-- Use ripgrep for grepping
vim.opt.grepprg = "rg --vimgrep --smart-case --follow"

-- -- Filetype-specific indentation settings
vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

-- JavaScript/TypeScript settings (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypeIndent",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "lua" },
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
      telescope.load_extension('file_browser')

      -- Keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
      vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'Search in buffer' })
      vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Command history' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
      vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Find marks' })
      vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Find symbols' })
      -- File browser
      vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<CR>', { noremap = true, desc = 'File browser' })
    end,
  },

  -- Gruvbox Theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Load theme before other plugins
    config = function()
      vim.o.background = "dark" -- or "light" for light version
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- Tmux integration
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        -- Enable copy mode navigation
        copy_sync = {
          -- Enable copy mode navigation
          enable = true,
          -- Remove default keybindings
          clear_registers = false,
          -- Sync registers
          sync_registers = true,
          -- Sync system clipboard
          sync_clipboard = true,
          -- Sync deletions
          sync_deletes = true,
          -- Sync latest paste
          sync_latest = true,
          -- Sync unnamed register
          sync_unnamed = true,
        },
        -- Enable navigation
        navigation = {
          -- Enable cycling through tmux sessions
          cycle_navigation = true,
          -- Enable navigation in copy mode
          enable_default_keybindings = true,
          -- Persist zoom in tmux
          persist_zoom = false,
        },
        -- Enable resurrection of tmux sessions
        resize = {
          -- Enable default keybindings
          enable_default_keybindings = true,
          -- Force same size for all panes
          force_equal = false,
          -- Resize amount
          resize_step_x = 1,
          resize_step_y = 1,
        }
      })

      -- local tmux_term = require('tmux.term')

      -- Additional keybindings for terminal management
      vim.keymap.set('n', '<C-h>', [[<Cmd>lua require("tmux").move_left()<CR>]])
      vim.keymap.set('n', '<C-j>', [[<Cmd>lua require("tmux").move_down()<CR>]])
      vim.keymap.set('n', '<C-k>', [[<Cmd>lua require("tmux").move_up()<CR>]])
      vim.keymap.set('n', '<C-l>', [[<Cmd>lua require("tmux").move_right()<CR>]])

      -- Optional: Terminal mappings
      -- vim.keymap.set('n', '<leader>th', function() tmux_term.toggle_term_main('h') end, { desc = 'Toggle horizontal terminal' })
      -- vim.keymap.set('n', '<leader>tv', function() tmux_term.toggle_term_main('v') end, { desc = 'Toggle vertical terminal' })
    end,
  },

  -- COC (Conquer of Completion)
  {
    "neoclide/coc.nvim",
    branch = "release",
    -- COC configuration
    config = function()
      -- Key mappings for COC
      local keyset = vim.keymap.set

      -- Autocomplete
      function _G.check_back_space()
          local col = vim.fn.col('.') - 1
          return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- <C-g>u breaks current undo, please make your own choice
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- GoTo code navigation
      keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

      -- Symbol renaming
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

      -- Highlight the symbol and its references on CursorHold
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })
    end,
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
          "cpp", "c", "rust", "markdown", "bash", "go", "json", "yaml"
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
    end,
  },

  -- Lualine for status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, 
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
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

  -- Check for updates
  checker = { enabled = true },
})
