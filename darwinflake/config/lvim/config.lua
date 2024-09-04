--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
lvim.builtin.dap.active = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Escape>"] = ":nohlsearch<cr>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.insert_mode["jj"] = "<ESC>"
lvim.keys.insert_mode["kk"] = "<ESC>"
lvim.keys.insert_mode["kj"] = "<ESC>"
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["/"] = nil

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

lvim.keys.normal_mode["<C-]>"] = ":ToggleTerm<cr>"
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm<CR>", "terminal" }
lvim.builtin.which_key.mappings["a"] = {
  name = "Ansible",
  d = { "<cmd>!ansible-vault decrypt % --vault-password-file=~/.vault_password<cr>", "decrypt" },
  e = { "<cmd>!ansible-vault encrypt % --vault-password-file=~/.vault_password<cr>", "encrypt" }
}

lvim.builtin.which_key.mappings["C"] = {

  name = "Crates",
  t = { "<cmd> :lua require('crates').toggle()<cr>", "Toggle" },
  R = { "<cmd> :lua require('crates').reload()<cr>", "Reload" },
  v = { "<cmd> :lua require('crates').show_versions_popup()<cr>", "Versions" },
  f = { "<cmd> :lua require('crates').show_features_popup()<cr>", "Features" },
  u = { "<cmd> :lua require('crates').update_crate()<cr>", "Update crate" },
  U = { "<cmd> :lua require('crates').update_all_crates()<cr>", "Update crates" },
  y = { "<cmd> :lua require('crates').upgrade_crate()<cr>", "Upgrade crate" },
  Y = { "<cmd> :lua require('crates').upgrade_all_crates()<cr>", "Upgrade all crates" },
  h = { "<cmd> :lua require('crates').open_homepage()<cr>", "Homepage" },
  r = { "<cmd> :lua require('crates').open_repository()<cr>", "Repository" },
  d = { "<cmd> :lua require('crates').open_documentation()<cr>", "Documentation" },
  C = { "<cmd> :lua require('crates').open_crates_io()<cr>", "Crates IO" },
  D = { "<cmd> :lua require('crates').show_dependencies_popup()<cr>", "Dependencies" },
}
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
--[[ lvim.builtin.nvimtree.show_icons.git = 0 ]]

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("ruff_lsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

lvim.plugins = {
  --   {"simrat39/rust-tools.nvim",
  -- require('rust-tools').setup({})
  --   },
}
-- Additional Plugins
lvim.plugins = {
  { "tpope/vim-surround", },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local status_ok, rust_tools = pcall(require, "rust-tools")
      if not status_ok then
        return
      end

      local opts = {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy"
              }
            }
          },
        },
      }
      --local extension_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.3/"

      --local codelldb_path = extension_path .. "adapter/codelldb"
      --local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

      --opts.dap = {
      --        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      --}
      rust_tools.setup(opts)
    end,
    ft = { "rust", "rs" },
  },
  -- { "simrat39/rust-tools.nvim",
  --   require("rust-tools").setup({
  -- server = {
  --   on_attach = function(_, bufnr)
  --     -- Hover actions
  --     -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  --     -- Code action groups
  --     -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  --   end,
  -- },
  --   })
  -- },
  { 'arouene/vim-ansible-vault' },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  -- { "oberblastmeister/neuron.nvim",
  --   require 'neuron'.setup {
  --     virtual_titles = true,
  --     mappings = true,
  --     run = nil, -- function to run when in neuron dir
  --     neuron_dir = "~/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
  -- leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
  -- } },
  {
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup_ts_grammar()
      require('orgmode').setup({
        org_agenda_files = { '~/org/*' },
        org_default_notes_file = '~/org/refile.org'
      })
    end
  },
  { 'nvim-lua/lsp_extensions.nvim' },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end,
  },
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  -- { "nvim-neorg/neorg",
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ["core.defaults"] = {},
  --         ["core.norg.dirman"] = {
  --           config = {
  --             workspaces = {
  --               work = "~/notes/work",
  --               home = "~/notes/personal",
  --             }
  --           }
  --         }
  --       }

  --     }
  --   end,
  --   dependencies = "nvim-lua/plenary.nvim"
  -- },
  -- { "github/copilot.vim" },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },
}
table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
-- vim.opt.mouse = ""
-- vim.opt.shell = "/bin/bash"
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
