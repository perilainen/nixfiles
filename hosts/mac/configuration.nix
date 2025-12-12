{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    brews = [ "mas" ];
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "brave-browser"
      # "rectangle"
      "bitwarden"
      "obsidian"
      "vmware-fusion"
      # "docker"
      "cursor"
      "hammerspoon"
      "raycast"
      "arc"
      # "stretchly"
      # "aerospace"
    ];
    # masApps = {Flycut = 442160987;};
    onActivation = {
      # autoUpdate = true;
      cleanup = "uninstall";
      # upgrade = true;
      # Set the default shell to zsh.
    };
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.pathsToLink = ["/Applications"];
  environment.systemPackages = [
    pkgs.vim
    # pkgs.darwin.apple_sdk.frameworks.Security
    pkgs.openconnect
    pkgs.fish
    pkgs.cachix
    pkgs.sketchybar
    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
    pkgs.pass
    pkgs.insomnia
    # pkgs.ensurePassStore
    # pkgs.raycast
    # pkgs.aerospace
  ];
  # services.colima.enable = true;
  services.yabai.enable = false;
  # services.yabai.config = {
  #   top_padding = 36;
  #   layout = "bsp";
  # };
  services.aerospace = {
    enable = true;
    settings = {
      after-login-command = [ ];
      after-startup-command = [ ];
      # start-at-login = true;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      on-focus-changed = [ "move-mouse window-lazy-center" ];
      automatically-unhide-macos-hidden-apps = false;

      key-mapping = {
        preset = "qwerty";
      };

      gaps = {
        inner = {
          horizontal = 10;
          vertical = 10;
        };
        outer = {
          left = 0;
          bottom = 0;
          top = 0;
          right = 0;
        };
      };

      mode = {
        main = {
          binding = {
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            alt-tab = "workspace-back-and-forth";
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
            # alt-shift-semicolon = "mode service";

            # Workspaces
            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";

            # Move node to workspace
            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-9 = "move-node-to-workspace 9";
            alt-shift-ctrl-h = "join-with left";
            alt-shift-ctrl-j = "join-with down";
            alt-shift-ctrl-k = "join-with up";
            alt-shift-ctrl-l = "join-with right";
          };
        };

        # service = {
        #   binding = {
        #     esc = "mode main";
        #     r = [ "flatten-workspace-tree", "mode main" ];
        #     f = [ "layout floating tiling", "mode main" ];
        #     backspace = [ "close-all-windows-but-current", "mode main" ];
        #
        #     alt-shift-h = [ "join-with left", "mode main" ];
        #     alt-shift-j = [ "join-with down", "mode main" ];
        #     alt-shift-k = [ "join-with up", "mode main" ];
        #     alt-shift-l = [ "join-with right", "mode main" ];
        #
        #     down = "volume down";
        #     up = "volume up";
        #     shift-down = [ "volume set 0", "mode main" ];
      };
      #   };
      # };
    };
  };
  services.sketchybar.enable = false;
  services.sketchybar.config = ''
    sketchybar --bar height=36 \
      blur_radius=20 \
      position=top \
      y_offset=6 \
      padding_left=2 \
      padding_right=2 \
      corner_radius=10 \
      margin=6 \
      color=0x44000000 \
      shadow=on

    sketchybar --default icon.font="JetBrainsMono NF:Bold:14.0"

    spaces=$(seq 9)
    space_args=()

    for i in ''${spaces[@]}; do
        sid=$((i))
        space_args+=(
            --add space space.$sid left \
            --set space.$sid icon=$sid \
                  associated_space=$sid \
                  icon.padding_right=6 \
                  icon.highlight_color=0xff768eff \
                  click_script="yabai -m space --focus $sid"
        )
    done

    sketchybar "''${space_args[@]}"

    sketchybar --add alias "Control Center,Clock" right \
               --add alias "Control Center,WiFi" right \
               --add alias "Control Center,Battery" right \
               --add alias "Control Center,Sound" right \
               --set "Control Center,Sound" \
                      click_script="sketchybar -m --set \"\$NAME\" popup.drawing=toggle" \
                      popup.blur_radius=7 \
                      popup.background.corner_radius=5 \
                      popup.background.color=0x44000000 \
               --add slider volume.slider popup."Control Center,Sound" 100 \
               --set volume.slider \
                      background.padding_left=5 \
                      background.padding_right=5 \
                      slider.background.height=5 \
                      slider.background.corner_radius=5 \
                      slider.background.color=0x66000000 \
                      slider.highlight_color=0xccffffff \
                      slider.percentage=$(osascript -e "output volume of (get volume settings)") \
                      click_script="osascript -e \"set volume output volume \$PERCENTAGE\""

    sketchybar --update
  '';

  nixpkgs.config.allowUnfree = true;
  # security.pam.enableSudoTouchIdAuth = true;
  security.pam.services.sudo_local.touchIdAuth = true;
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  # nix.settings.experimental-features = "nix-command flakes";
  nix = {
    enable = true;
    settings = {
      experimental-features = "nix-command flakes";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      # user = "perjohansson";
    };
    # linux-builder = {
    #   enable = true;
    # };
    #   maxJobs = 4;
    #   package = "nixpkgs-old.darwin.linux-builder";
    #   config = {
    #     virtualisation = {
    #       darwin-builder = {
    #         diskSize = 40 * 1024;
    #         memorySize = 8 * 1024;
    #     };
    #   };
    # };
  };
  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;
  # programs.hammerspoon.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  users.users.perjohansson = {
    home = "/Users/perjohansson";
    shell = pkgs.zsh;
  };

  # The platform the configuration will be used on.
  # nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "perjohansson";
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };
}
