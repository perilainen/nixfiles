{ config, pkgs, ... }:

{
  # nixpkgs.config.allowBroken = true;
  home = {

    file.".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
    file.".config/kitty/current-theme.conf".source = ./config/kitty/current-theme.conf;
    file.".config/lvim/config.lua".source = ./config/lvim/config.lua;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "perjohansson";
    homeDirectory = "/Users/perjohansson";

    # nixpkgs.config.allowUnfree = true;
    packages = with pkgs; [
      ansible_2_13
      bottom
      # cmake
      # clang
      ctags
      cyrus_sasl
      # darwin.apple_sdk.frameworks.Security
      ddgr
      # direnv
      # docker replaced by podman
      # docker
      # docker-compose
      # docker-machine
      exa
      fasd
      fd
      ffmpeg
      # fish
      fzf
      gdb
      gitui
      # go
      grpcurl
      inetutils
      # jdk11
      jq
      helix
      k9s
      kubectl
      kubeseal
      lazygit
      llvm
      lua
      lua53Packages.luarocks
      mas
      minio-client
      mpv
      netcat
      neuron-notes
      neovim
      nodejs
      nmap
      openssl_3
      podman
      podman-compose
      postgresql
      protobuf
      ranger
      rdkafka
      ripgrep
      rustup
      SDL
      sshs
      starship
      tig
      tmux
      translate-shell
      tree-sitter
      youtube-dl
      w3m
      wget
      # yarn
      zellij
      qemu
      # maven
    ];
    sessionVariables = {
      EDITOR = "lvim";
    };
    stateVersion = "22.05";
  };
  programs.direnv =
    {
      enable = true;
      nix-direnv.enable = true;
    };
  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };
  };
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        temperature_type = "c";
      };
    };

  };
  programs.git = {
    enable = true;
    userName = "Per Johansson";
    userEmail = "per.a.johansson@svt.se";
    aliases =
      {
        ap = "add --patch";
      };
    extraConfig = {
      pull = {
        rebase = true;
      };
    };
  };
  programs.fish = {
    enable = true;
    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "iterm2-shell-integration";
        src = ./config/fish/iterm2_shell_integration;

      }
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
      {
        name = "theme-bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "1eaed8c39951029fa7839859abd5518977a80f83";
          sha256 = "sha256-whTAO4ZxglCr9vm/WXJItwnVoHZYG3qKh9rYWF5dhaE=";
        };
      }

      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          # rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";

          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
    shellInit = ''
      # Set syntax highlighting colours; var names defined here:
      # http://fishshell.com/docs/current/index.html#variables-color
      set fish_color_autosuggestion magenta
    '';
    interactiveShellInit = ''
      # iterm2_shell_integration
      set fish_color_cwd --bold white
      set fish_color_user --bold blue
    '';
    shellAliases = {
      l = "exa";
      so = "ddgr -w stackoverflow.com";
      drd = "ddgr -w doc.rust-lang.org";
    };
    shellAbbrs = {
      g = "git";
      m = "make";
      n = "nvim";
      o = "open";
      p = "python3";
    };
    functions = {
      # fish_greeting = {
      #   description = "Greeting to show when starting a fish shell";
      #   body = "Welcome you are in fish";
      # };
      take = {
        description = "Make a directory tree and enter it";
        body = "mkdir -p $argv[1]; and cd $argv[1]";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.man.generateCaches = true;
}
