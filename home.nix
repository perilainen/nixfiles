{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];
  # nixpkgs.config.allowBroken = true;
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    # ./packages.nix
    ../../shared.nix
    ../../shared_programs/default.nix
    # ./neovim
    ../../neovim
  ];
  home = {
    file.".config/lvim/config.lua".source = ./config/lvim/config.lua;
    file."/Users/perjohansson/Library/Application Support/k9s/hotkey.yml".source = ./config/k9s/hotkey.yml;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "perjohansson";
    # homeDirectory = "/Users/perjohansson2";

    packages = with pkgs;
      [
        autojump
        ctags
        cyrus_sasl
        ddgr
        devenv
        elixir
        fd
        ffmpeg
        fzf
        git-lfs
        gnused
        go
        hstr
        mage
        grpcurl
        inetutils
        # jq
        k9s
        kubectl
        kubeseal
        llvm
        lua
        lua53Packages.luarocks
        mas
        minio-client
        netcat
        nerd-fonts.fira-code
        # neovim
        nil
        nodejs
        nmap
        pipenv
        podman
        podman-compose
        postgresql
        protobuf
        rdkafka
        ripgrep
        rustup
        SDL
        sshs
        starship
        thefuck
        # tig
        tmux
        translate-shell
        tree-sitter
        w3m
        websocat
        wget
        yarn
        yazi
        zellij
        qemu
        nodePackages.typescript-language-server
        yaml-language-server
        marksman
      ]
      ++ (lib.optionals isDarwin [
        tig
      ]);
    sessionPath = [
      "$HOME/.cargo/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      SOPS_AGE_KEY_DIR = "~/.config/sops/age";
    };
    stateVersion = "22.05";
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    themeFile = "Catppuccin-Macchiato";
    keybindings = {
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+enter" = "goto_layout stack";
    };
    settings = {
      enable_audio_bell = false;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      open = "lvim";
    };
  };
  programs.tmate = {
    enable = true;
  };
  programs.mpv = {
    enable = true;
  };
  programs.xplr.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.git = {
    lfs.enable = true;
    enable = true;
    userName = "Per Johansson";
    userEmail = "per.a.johansson@svt.se";
    aliases = {
      ap = "add --patch";
    };
    extraConfig = {
      url."git@git.svt.se:".insteadOf = "https://git.svt.se/";
      url."git@github.com:".insteadOf = "https://github.com/";
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      fetch.prune = true;
      rebase.autostash = true;
      merge.tool = "nvim";
      mergetool.keepBackup = false;
      mergetool.prompt = false;
      mergetool.lvim.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c 'wincmd w' -c 'wincmd J'";
    };
  };
  # programs.helix = {
  #   enable = true;
  #   settings.keys.normal."," = {
  #     s = "split_selection_on_newline";
  #   };
  #   settings.keys.normal.esc = [ "collapse_selection" "keep_primary_selection" ];
  # };
  programs.fish = {
    enable = true;
    plugins = [
    ];
    shellInit = ''
      # Set syntax highlighting colours; var names defined here:
      # http://fishshell.com/docs/current/index.html#variables-color
      set fish_color_autosuggestion magenta
      abbr reka --set-cursor=! "sed -i '!d' /Users/perjohansson/.ssh/known_hosts "
    '';
    interactiveShellInit = ''
      # iterm2_shell_integration
      set fish_color_cwd --bold white
      set fish_color_user --bold blue
    '';
    shellAliases = {
      x = "clear";
      so = "ddgr -w stackoverflow.com";
      drd = "ddgr -w doc.rust-lang.org";
      linuxdev = "docker run -itv $(pwd):/home/dev/workspace --rm -w /home/dev/workspace arch-dev bash";
      vpnnps = "sudo openconnect --user=pejo03 --useragent=AnyConnect --gnutls-priority=NORMAL:-VERS-ALL:+VERS-TLS1.2:+RSA:+AES-128-CBC:+SHA1 asavpn.svt.se/NPStest";
      vpnsvt = "sudo openconnect --user=pejo03 --useragent=AnyConnect  --gnutls-priority=NORMAL:-VERS-TLS1.3 asavpn.svt.se/svtvpn";
      vpnnova = "sudo openconnect --user=pejo03 --useragent=AnyConnect --gnutls-priority=NORMAL:-VERS-ALL:+VERS-TLS1.2:+RSA:+AES-128-CBC:+SHA1 asavpn.svt.se/novavpn";
      sysup = "darwin-rebuild switch --flake ~/nixfiles/.";
      lvim = "nvim -u ~/.config/nvim/lazyviminit.lua";
    };
    shellAbbrs = {
      g = "git";
      m = "make";
      n = "nvim";
      o = "open";
      p = "python3";
      dus = "du -sh ./* | sort -h";
      se = "TERM=xterm ssh -J smash.svt.se";
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
