{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    # extraConfigLua = builtins.readFile ./init.lua;
    defaultEditor = true;
    extraConfigLua = builtins.readFile ./my.lua;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        term_colors = true;
        styles = {
          keywords = ["italic"];
          conditionals = ["bold"];
          loops = ["bold"];
          functions = ["bold"];
          properties = ["italic"];
          booleans = ["bold" "italic"];
          operators = ["bold"];
        };
        integrations = {
          # barbar = true;
          gitsigns = true;
          indent_blankline = {
            enabled = true;
            colored_indent_levels = true;
          };
          lsp_trouble = true;
          #  mini = true;
          native_lsp.enabled = true;
          navic.enabled = true;
          nvimtree = true;
          treesitter = true;
          treesitter_context = true;
          ts_rainbow2 = true;
        };
      };
    };

    opts = {
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      shiftwidth = 0;
      tabstop = 2;
      showtabline = 2;
      expandtab = true;
      smarttab = true;
      showmode = false;
      undofile = true;
      list = true;
      swapfile = false;
      tw = 79;
      ignorecase = true;
      smartcase = true;
      wrap = false;
      # completeopt = "menuone,menuone,noselect";
    };

    globals = {
      mapleader = ",";
      rust_recommended_style = false;
      neovide_cursor_animation_length = 2.5e-2;
      neovide_cursor_vfx_mode = "railgun";
      neovide_background_color = "#1e1e2f";
    };
    keymaps = [
      {
        mode = "n";
        key = "<esc>";
        options.silent = true;
        action = "<CMD>noh<CR>";
      }
      {
        mode = "n";
        key = "<leader>ln";
        options.silent = true;
        action = "<cmd>Navbuddy<CR>";
      }
      {
        mode = "n";
        key = "<leader>la";
        options.silent = true;
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<leader>lf";
        options.silent = true;
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
      }
      {
        mode = "n";
        key = "<leader>ss";
        options.silent = true;
        action = "<cmd>:Telescope<CR>";
      }
      {
        mode = "n";
        key = "<leader>lw";
        options.silent = true;
        action = "<cmd>Telescope diagnostics<CR>";
      }
      {
        mode = "n";
        key = "<leader>gg";
        options.silent = true;
        action = "<cmd>LazyGit<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        options.silent = true;
        action = "<cmd>NvimTreeToggle<CR>";
      }
    ];

    # maps = config.nixvim.helpers.mkMaps { silent = true; } {
    #   normal = {
    #     "<C-h>".action = "<CMD>BufferPrevious<CR>";
    #     "<C-l>".action = "<CMD>BufferNext<CR>";
    #     "<Leader>lg".action = "<CMD>LazyGit<CR>";
    #     "<Leader>la".action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
    #     "<Leader>lk".action = "<CMD>lua vim.lsp.buf.hover()<CR>";
    #     "<Leader>be".action = "<CMD>BufferPickDelete<CR>";
    #     "<Leader>bf".action = "<CMD>BufferPick<CR>";
    #     "<Leader>e".action = "<CMD>NvimTreeToggle<CR>";
    #     "<Leader>rn".action = "<CMD>lua require('renamer').rename()<CR>";
    #     "<Leader>p".action = "<CMD>!pst %<CR>";
    #   };

    #   terminal."<C-t>".action = "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>";

    #   visual."<Leader>rn".action = "<CMD>lua require('renamer').rename()<CR>";
    # };

    plugins = {
      project-nvim.enable = true;
      # alpha.enable = true;
      gitsigns.enable = true;
      gitblame.enable = true;
      gitmessenger.enable = true;
      web-devicons.enable = true;

      navbuddy = {
        enable = true;
        lsp.autoAttach = true;
      };
      luasnip.enable = true;
      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_x = ["lsp_progress" "encoding"];
          };
        };
      };
      toggleterm = {
        enable = true;
        # openMapping = "<C-\\>";
        settings = {
          direction = "float";
        };
      };

      oil.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      cmp = {
        enable = true;

        settings = {
          experimental = {ghost_text = true;};
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "nvim_lua";}
            {name = "path";}
            {name = "copilot";}
            {name = "codeium-vim";}
          ];

          formatting = {
            fields = ["abbr" "kind" "menu"];
            format =
              # lua
              ''
                function(_, item)
                  local icons = {
                    Namespace = "󰌗",
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰆧",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈚",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "󰊄",
                    Table = "",
                    Object = "󰅩",
                    Tag = "",
                    Array = "[]",
                    Boolean = "",
                    Number = "",
                    Null = "󰟢",
                    String = "󰉿",
                    Calendar = "",
                    Watch = "󰥔",
                    Package = "",
                    Copilot = "",
                    Codeium = "",
                    TabNine = "",
                  }

                  local icon = icons[item.kind] or ""
                  item.kind = string.format("%s %s", icon, item.kind or "")
                  return item
                end
              '';
          };

          window = {
            completion = {
              winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
              scrollbar = false;
              sidePadding = 0;
              border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
            };

            settings.documentation = {
              border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
              winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
            };
          };

          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<S-Tab>" = "cmp.mapping.close()";
            "<Tab>" =
              # lua
              ''
                function(fallback)
                  local line = vim.api.nvim_get_current_line()
                  if line:match("^%s*$") then
                    fallback()
                  elseif cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                  else
                    fallback()
                  end
                end
              '';
            "<Down>" =
              # lua
              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                  else
                    fallback()
                  end
                end
              '';
            "<Up>" =
              # lua
              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                  else
                    fallback()
                  end
                end
              '';
          };
        };
      };
      # nvim-cmp = {
      # enable = true;
      # snippet.expand = "luasnip";
      # formatting = {
      #   format = ''
      #     require("lspkind").cmp_format({
      #             mode="symbol",
      #             maxwidth = 50,
      #             ellipsis_char = "..."
      #     })
      #   '';
      # };
      # };

      # nvim-cmp.mappingPresets = ["insert"];

      # nvim-cmp.mapping = {
      #   "<CR>" = "cmp.mapping.confirm({ select = false })";
      #   "<C-j>" = "cmp.mapping.scroll_docs(4)";

      #   modes = ["i" "s"];
      #   action = ''
      #     function(fallback)
      #       if cmp.visible() then
      #         cmp.select_next_item()
      #       else
      #         fallback()
      #       end
      #     end
      #   '';
      # action = ''
      #   function(fallback)
      #     if cmp.visible() then
      #       cmp.select_next_item()
      #     elseif luasnip.expandable() then
      #       luasnip.expand()
      #     elseif luasnip.expand_or_jumpable() then
      #       luasnip.expand_or_jump()
      #     elseif check_backspace() then
      #       fallback()
      #     else
      #       fallback()
      #     end
      #   end
      # '';
      # };
      # };
      # nvim-cmp.sources = [
      #   {name = "nvim_lsp";}
      #   {name = "luasnip";}
      #   {name = "buffer";}
      #   {name = "copilot";}
      # ];
      # nvim-cmp.window.documentation.maxWidth = "40";
      # copilot-cmp.enable = true;
      codeium-vim.enable = true;

      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
      };
      # noice.enable = true;
      # notify= {
      # enable = true;
      # };
      which-key.enable = true;
      comment.enable = true;
      emmet.enable = true;
      nvim-autopairs.enable = true;
      nvim-lightbulb.enable = true;
      todo-comments.enable = true;

      barbar = {
        enable = true;
        # autoHide = true;
        # icons.diagnostics = {
        #   error.enable = true;
        #   hint.enable = true;
        #   info.enable = true;
        #   warn.enable = true;
        # };
      };

      # coq-nvim = {
      #   enable = true;
      #   autoStart = "shut-up";
      #   installArtifacts = true;
      #   recommendedKeymaps = true;
      # };

      lsp-format = {enable = true;};
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>lk" = "goto_prev";
            "<leader>lj" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<leader>lr" = "rename";
          };
        };

        # onAttach = ''
        #   if client.supports_method('textDocument/codeLens') then
        #     require('virtualtypes').attach(client, bufnr)
        #   end
        #
        #   if client.server_capabilities.documentSymbolProvider then
        #       require('nvim-navic').attach(client, bufnr)
        #       require('nvim-navbuddy').attach(client, bufnr)
        #   end
        #
        #   if client.supports_method('textDocument/formatting') then
        #     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        #     vim.api.nvim_create_autocmd('BufWritePre', {
        #       group = augroup,
        #       buffer = bufnr,
        #       callback = function()
        #         if client.name == 'null-ls' then
        #           local util = require 'vim.lsp.util'
        #           local params = util.make_formatting_params({})
        #           client.request('textDocument/formatting', params, nil, bufnr)
        #         end
        #         vim.lsp.buf.fmtrmat({bufnr = bufnr})
        #         require('mini.trailspace').trim()
        #         require('mini.trailspace').trim_last_lines()
        #       end,
        #     })
        #
        #   end
        # '';

        servers = {
          #eslint.enable = true;
          lua_ls.enable = true;
          nixd.enable = true;
          nil_ls.enable = true;
          #tailwindcss.enable = true;
          ts_ls.enable = true;
          # tsserver.enable = true;
          clangd.enable = true;
          gopls.enable = true;
          html.enable = true;
          yamlls.enable = true;
          ruff.enable = true;
          kotlin_language_server.enable = true;
          pyright = {
            enable = true;
            # plugins.rope.enabled = true;
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;

            settings = {
              imports.granularity = {
                enforce = true;
                group = "item";
              };
              files.excludeDirs = [".direnv"];
            };

            extraOptions.settings = {
              cargo.allFeatures = true;
              files.excludeDirs = [".direnv"];
              unstable_features = true;
              #   tab_spaces = 2;
              #   reorder_impl_items = true;
              #   indent_style = "Block";
              #   imports_layout = "HorizontalVertical";
              #   group_imports = "StdExternalCrate";
              normalize_comments = true;
              format_code_in_doc_comments = true;
            };
          };
        };
      };

      none-ls = {
        enable = true;
        sources.formatting = {
          alejandra.enable = true;
          # nixfmt.enable = true;
          stylua.enable = true;
        };
      };

      # nvim-jdtls = {
      #   enable = true;
      #   data = "/Users/marshall/.cache/jdt-language-server/workspace";
      #   configuration = "/Users/marshall/.cache/jdt-language-server/config";
      # };

      nvim-tree = {
        enable = true;
        git.enable = true;
        disableNetrw = true;
        respectBufCwd = true;
        reloadOnBufenter = true;
        syncRootWithCwd = true;
        updateFocusedFile.enable = true;

        diagnostics = {
          enable = true;
          icons = {
            hint = "";
            info = "";
            warning = "";
            error = "";
          };
        };
      };

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
        settings.defaults.layout_config.vertical.height = 0.5;
        keymaps = {
          "<leader>st" = "live_grep";
          "<leader>sf" = "find_files";
          "<leader>sb" = "buffers";
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      lualine-lsp-progress
      lspkind-nvim
      luasnip
      #   barbecue-nvim
      #   diffview-nvim
      #   feline-nvim
      #   FixCursorHold-nvim
      #   FTerm-nvim
      # gitsigns-nvim
      #   indent-blankline-nvim
      #   instant-nvim
      lazygit-nvim
      markdown-preview-nvim
      #   mini-nvim
      #   mkdir-nvim
      #   nui-nvim
      # nvim-colorizer-lua
      # nvim-lightbulb
      #   nvim-navic
      #   nvim-ts-rainbow2
      #   nvim-web-devicons
      #   octo-nvim
      #   plenary-nvim
      #   presence-nvim
      #   renamer-nvim
      #   telescope-ui-select-nvim
      #   trouble-nvim
      #   vim-cool
      #   vim-smoothie
      #   vim-unimpaired
      #   vim-visual-multi
      #   virtual-types-nvim
      #   zen-mode-nvim
    ];
  };
}
