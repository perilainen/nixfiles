{
  pkgs,
  lib,
  ...
}: let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # ref = "nixos-23.05";
  });
in {
  imports = [nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    # extraConfigLua = builtins.readFile ./init.lua;
    extraConfigLua = builtins.readFile ./my.lua;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      terminalColors = true;

      integrations = {
        barbar = true;
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

      styles = {
        booleans = ["bold" "italic"];
        conditionals = ["bold"];
        functions = ["bold"];
        keywords = ["italic"];
        loops = ["bold"];
        operators = ["bold"];
        properties = ["italic"];
      };
    };

    options = {
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
      # completeopt = "menuone,menuone,noselect";
    };

    globals = {
      mapleader = " ";
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
      navbuddy = {
        enable = true;
        lsp.autoAttach = true;
      };
      luasnip.enable = true;
      lualine = {
        enable = true;
        sections = {
          lualine_x = ["lsp_progress" "encoding"];
        };
      };
      toggleterm = {
        enable = true;
        openMapping = "<C-\\>";
        direction = "float";
      };

      oil.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        formatting = {
          format = ''
            require("lspkind").cmp_format({
                    mode="symbol",
                    maxwidth = 50,
                    ellipsis_char = "..."
            })
          '';
        };
      };

      nvim-cmp.mappingPresets = ["insert"];

      nvim-cmp.mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<C-j>" = "cmp.mapping.scroll_docs(4)";
        "<C-k>" = "cmp.mapping.scroll_docs(-4)";
        "<Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
        };
      };
      nvim-cmp.sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "buffer";}
        {name = "copilot";}
      ];
      # nvim-cmp.window.documentation.maxHeight = "400";
      # nvim-cmp.window.documentation.maxWidth = "40";
      # copilot-cmp.enable = true;
      copilot-lua.enable = true;
      # noice.enable = true;
      # notify= {
      # enable = true;
      # };
      which-key.enable = true;
      comment-nvim.enable = true;
      emmet.enable = true;
      nvim-autopairs.enable = true;
      nvim-lightbulb.enable = true;
      todo-comments.enable = true;

      barbar = {
        enable = true;
        autoHide = true;
        icons.diagnostics = {
          error.enable = true;
          hint.enable = true;
          info.enable = true;
          warn.enable = true;
        };
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
          eslint.enable = true;
          lua-ls.enable = true;
          nixd.enable = true;
          nil_ls.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
          gopls.enable = true;
          html.enable = true;
          yamlls.enable = true;
          rust-analyzer = {
            enable = true;
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
        extraOptions.defaults.layout_config.vertical.height = 0.5;
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
