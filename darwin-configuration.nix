{ config, pkgs, ... }:

{
  hemebrew = {
    enable = true;
    autoUpdate = true;
    brews = [ "mas" ];
    casks = [ "brave-browser" "visual-studio-code" "bloomrpc" "rectangle" "bitwarden" "docker" ];
    masApps = { Flycut = 442160987; };
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
      # Set the default shell to zsh.
    };
  };
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.brews = [ "mas" ];
  homebrew.casks = [ "brave-browser" "kitty" "visual-studio-code" "bloomrpc" "rectangle" "bitwarden" "docker" ];
  homebrew.masApps = { Flycut = 442160987; };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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
  };
  environment.systemPackages =
    [
      pkgs.openconnect
      pkgs.vim
      # pkgs.darwin.apple_sdk.frameworks.Security
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [ "root" "perjohansson" "@wheel" ];
    extraOptions = ''
      extra-platforms = aarch64-darwin x86_64-darwin
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      # dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings.extra-trusted-users = [ "perjohansson" "@admin" ];
    linux-builder = {
      enable = true;
      maxJobs = config.nix.settings.max-jobs;
      config = {
        virtualisation = {
          darwin-builder = {
            diskSize = 40 * 1024;
            memorySize = 8 * 1024;
          };
          cores = 6;
        };
      };
    };
  };
  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
