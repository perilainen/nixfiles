{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # ref = "nixos-23.05";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS
    # For nix-darwin
    ./lsp.nix
  ];

  programs.nixvim = {
    enable = true;
    luaLoader.enable = true;
    colorschemes.onedark.enable = true;
    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
    globals.mapleader = " ";
    plugins = {
      nvim-tree.enable = true;
      nvim-cmp = {
        enable = true;

        formatting.format = ''
          require('lspkind').cmp_format({mode = 'symbol', maxwidth = 50})
        '';

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };


        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };
      };
      which-key.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      nvim-autopairs.enable = true;
      rust-tools.enable = true;
      treesitter.enable = true;
      noice.enable = true;
      notify.enable = true;
#      lsp = {
#        enable = true;
#        keymaps.lspBuf = {
#          "K" = "hover";
#        };
#      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>st" = "live_grep";
          "<leader>sf" = "find_files";
          "<leader>sb" = "buffers";
        };
      };
      lightline.enable = true;
      toggleterm = {
        enable = true;
        openMapping = "<C-\\>";
      };
      none-ls.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
    lspkind-nvim
    ];
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      termguicolors = true;
      undofile = true;
      list = true;
      completeopt = "menuone,menuone,noselect";
      expandtab = true;
      smarttab = true;
      swapfile = false;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
      }
    ];
  };
}
