{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  system = pkgs.stdenv.system;
in
{
  # nixpkgs.config.allowBroken = true;
  imports = [
    inputs.nixvim.homeModules.nixvim
    # inputs.nixvim.homeManagerModules.nixvim
    # ./packages.nix
    ./shared.nix
    ./shared_programs/default.nix
    ./neovim
    ./clipboard-logger.nix
    # ./neovim
    # These does not work on mac how do i contitionally import them
    # ./waybar.nix
    # ./hypr
  ];
  # ++ (lib.optionals isDarwin [./neovim]);
  # ++ (lib.optionals isLinux [
  # ./waybar.nix
  # ]);
  services.clipboardLogger = {
    enable = true;
  };
  home = {
    file =
      { }
      // (
        if isDarwin then
          {
            # "/Users/perjohansson/.aerospace.toml".source = ./config/aerospace/aerospace.toml;
            # ".config/lvim/config.lua".source = ./config/lvim/config.lua;
            # "/Users/perjohansson/Library/Application Support/k9s/hotkey.yml".source = ./config/k9s/hotkey.yml;
          }
        else
          { }
      );

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "perjohansson";
    # homeDirectory = "/Users/perjohansson2";

    packages =
      with pkgs;
      [
        # autojump
        ctags
        cyrus_sasl
        dbeaver-bin
        ddgr
        devenv
        discord
        elixir
        fd
        ffmpeg
        fzf
        git-lfs
        gnused
        go
        glab
        hstr
        mage
        grpcurl
        inetutils
        # jq
        # k9s
        kubectl
        kubeseal
        lazyssh
        llvm
        lua
        lua53Packages.luarocks
        minio-client
        netcat
        # nerdfonts
        #nerd-fonts.fira-code
        # neovim
        nil
        # nodejs
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
        pay-respects
        # thefuck
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
        nodePackages.typescript-language-server
        yaml-language-server
        marksman
      ]
      ++ (lib.optionals isDarwin [
        tig
        qemu
        mas
      ])
      ++ (lib.optionals isLinux [
        brave
        # google-chrome
        hyprpicker
        swayidle
        wlogout
        gcc
        hyprcursor
        firefox

        bitwarden
        pavucontrol
        mpd
        vim
        nh
        manix
        comma
        nyxt
        noto-fonts
        # nerd-fonts.fira-code
        # nerd-fonts.iosevka-term-slab
        # nerd-fonts.symbols-only
        font-awesome
      ])
      ++ (lib.optional (system == "x86_64-linux") [
        google-chrome
        cider
      ]);
    sessionPath = [
      "$HOME/.cargo/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      SOPS_AGE_KEY_DIR = "~/.config/sops/age";
    };
    stateVersion = "24.11";
  };
  # home.pointerCursor =
  #   if isLinux
  #   then {
  #     gtk.enable = true;
  #     x11.enable = true;
  #     package = pkgs.whitesur-cursors;
  #     name = "WhiteSur-cursors";
  #     size = 16;
  #   }
  #   else {};
  gtk =
    if isLinux then
      {
        enable = true;
        iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
        };

        font = {
          name = "Sans";
          size = 11;
        };
      }
    else
      { };
  fonts =
    if isLinux then
      {
        fontconfig.enable = true;
      }
    else
      { };
  programs.kodi =
    if isLinux then
      {
        enable = true;
      }
    else
      { };
  programs.fastfetch.enable = true;
  programs.navi.enable = true;
  programs.autojump = {
    enable = true;
  };
  programs.intelli-shell = {
    enable = true;
    enableFishIntegration = true;
    shellHotkeys = {
      search_hotkey = "\\\\C-t"; # Alt (ESC) + Enter (\r)
    };
  };
  programs.foot = {
    enable = isLinux;
    settings = {
      main = {
        term = "xterm-256color";

        # font = "Fira Code:size=11";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        foreground = "cdd6f4"; # Text
        background = "1e1e2e"; # Base
        regular0 = "45475a"; # Surface 1
        regular1 = "f38ba8"; # red
        regular2 = "a6e3a1"; # green
        regular3 = "f9e2af"; # yellow
        regular4 = "89b4fa"; # blue
        regular5 = "f5c2e7"; # pink
        regular6 = "94e2d5"; # teal
        regular7 = "bac2de"; # Subtext 1
        bright0 = "585b70"; # Surface 2
        bright1 = "f38ba8"; # red
        bright2 = "a6e3a1"; # green
        bright3 = "f9e2af"; # yellow
        bright4 = "89b4fa"; # blue
        bright5 = "f5c2e7"; # pink
        bright6 = "94e2d5"; # teal
        bright7 = "a6adc8"; # Subtext 0
      };
    };
  };

  # programs.obs-studio.enable = true;
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
      allow_remote_control = "yes";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      open = "nvim";
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
    enableBashIntegration = true;
    # enableFishIntegration = true;
  };
  programs.git = {
    lfs.enable = true;
    enable = true;
    userName = "Per Johansson";
    userEmail = "per.a.johansson@svt.se";
    aliases = {
      ap = "add --patch";
    };
    signing.format = "openpgp";
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
      sysup = "sudo darwin-rebuild switch --flake ~/nixfiles/.";
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
      flakeinspect = "nix repl --expr 'let flake = builtins.getFlake \"$PWD\";
      pkgs = import <nixpkgs> {}; in { inherit pkgs flake; }'";
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
  programs.waybar = {
    enable = isLinux;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [
          "clock"
          "custom/suspend"
          "custom/logout"
        ];
        modules-left = [
          "hyprland/workspaces"
          "hyplrland/mode"
          "hyprland/window"
          "sway/scratchpad"
          "custom/startmenu"
        ];
        modules-right = [
          "hyprland/language"
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = '' {:L%H:%M}  '';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && wofi --show drun -I";
        };
        "custom/suspend" = {
          format = "";
          on-click = "sleep 0.1 && systemctl suspend";
          tooltip = false;
        };
        "custom/logout" = {
          format = "";
          on-click = "sleep 0.1 && pklitt -u $USER";
          tooltip = false;
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-hypr-bindings";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
      }
    ];
    style = lib.concatStrings [
      ''

        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
            font-size: 13px;
        }

        window#waybar {
            background-color: rgba(43, 48, 59, 0.5);
            border-bottom: 3px solid rgba(100, 114, 125, 0.5);
            color: #ffffff;
            transition-property: background-color;
            transition-duration: .5s;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        /*
        window#waybar.empty {
            background-color: transparent;
        }
        window#waybar.solo {
            background-color: #FFFFFF;
        }
        */

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: #ffffff;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        #workspaces button.focused {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #mode {
            background-color: #64727D;
            border-bottom: 3px solid #ffffff;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #scratchpad,
        #custom-suspend
        #mpd {
            padding: 0 10px;
            color: #ffffff;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            background-color: #64727D;
        }

        #battery {
            background-color: #ffffff;
            color: #000000;
        }

        #battery.charging, #battery.plugged {
            color: #ffffff;
            background-color: #26A65B;
        }

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }

        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        label:focus {
            background-color: #000000;
        }

        #cpu {
            background-color: #2ecc71;
            color: #000000;
        }

        #memory {
            background-color: #9b59b6;
        }

        #disk {
            background-color: #964B00;
        }

        #backlight {
            background-color: #90b1b1;
        }

        #network {
            background-color: #2980b9;
        }

        #network.disconnected {
            background-color: #f53c3c;
        }

        #pulseaudio {
            background-color: #f1c40f;
            color: #000000;
        }

        #pulseaudio.muted {
            background-color: #90b1b1;
            color: #2a5c45;
        }

        #wireplumber {
            background-color: #fff0f5;
            color: #000000;
        }

        #wireplumber.muted {
            background-color: #f53c3c;
        }

        #custom-media {
            background-color: #66cc99;
            color: #2a5c45;
            min-width: 100px;
        }

        #custom-media.custom-spotify {
            background-color: #66cc99;
        }

        #custom-media.custom-vlc {
            background-color: #ffa000;
        }

        #temperature {
            background-color: #f0932b;
        }

        #temperature.critical {
            background-color: #eb4d4b;
        }

        #tray {
            background-color: #2980b9;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
        }

        #idle_inhibitor {
            background-color: #2d3436;
        }

        #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
        }

        #mpd {
            background-color: #66cc99;
            color: #2a5c45;
        }

        #mpd.disconnected {
            background-color: #f53c3c;
        }

        #mpd.stopped {
            background-color: #90b1b1;
        }

        #mpd.paused {
            background-color: #51a37a;
        }

        #language {
            background: #00b093;
            color: #740864;
            padding: 0 5px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state {
            background: #97e1ad;
            color: #000000;
            padding: 0 0px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state > label {
            padding: 0 5px;
        }

        #keyboard-state > label.locked {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad.empty {
        	background-color: transparent;
        }
        #custom-startmenu {
            background: rgba(0, 0, 0, 0.2);
            padding: 0 10px;
        }
        #custom-suspend, #custom-logout {

            background: rgba(0, 0, 0, 0.2);
            padding: 0 10px;
        }

      ''
    ];
  };
  wayland.windowManager.hyprland = {
    enable = isLinux;
    extraConfig = ''
      monitor=,preferred,auto,auto


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox
      exec-once = kitty & brave & cider

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,24
      env = XCURSOR_THEME,breeze
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_QPA_PLATFORM, wayland

      input {
          kb_layout = us(mac),se(us),us,us(altgr-intl),se
          kb_variant = altgr-intl
          kb_model = applealu_ansi
          kb_options = caps:escape,lv3:lalt_switch,lv3:ralt_alt,grp:shift_caps_toggle,compose:rwin
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = true
          layout = dwindle

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10

          blur {
              enabled = true
              size = 3
              passes = 1
          }

          # drop_shadow = yes
          # shadow_range = 4
          # shadow_render_power = 3
          # col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      # master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          # new_is_master = true
      # }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic-mouse-v1 {
          # sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      bind = SUPER CTRL, l, movecurrentworkspacetomonitor , +1
      unbind=CTRL, w

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      bind = SUPER, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, yazi
      bind = $mainMod, F, togglefloating,
      bind = $mainMod, R, exec, wofi --show drun -I
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # exec-once=bash ~/.config/hypr/start.sh
      # exec-once=bash ~/.config/hypr/start2.sh
      exec-once = wl-paste --type text --watch cliphist store #Stores only text data

      exec-once = wl-paste --type image --watch cliphist store #Stores only image data


    '';
  };
  programs.bat.enable = true;
  programs.wofi = {
    enable = isLinux;
    settings = {
      allow-images = true;
    };
    style = ''
      window {
      margin: 0px;
      border: 1px solid #88c0d0;
      background-color: #2e3440;
      }

      #input {
      margin: 5px;
      border: none;
      color: #d8dee9;
      background-color: #3b4252;
      }

      #inner-box {
      margin: 5px;
      border: none;
      background-color: #2e3440;
      }

      #outer-box {
      margin: 5px;
      border: none;
      background-color: #2e3440;
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      color: #d8dee9;
      }

      #entry:selected {
      background-color: #3b4252;
      }
    '';
  };
  programs.obs-studio.enable = isLinux;
}
