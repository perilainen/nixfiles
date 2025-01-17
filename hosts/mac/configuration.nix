{pkgs, ...}: {
  homebrew = {
    enable = true;
    brews = ["mas"];
    casks = ["brave-browser" "rectangle" "bitwarden" "docker" "obsidian"];
    masApps = {Flycut = 442160987;};
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
      # Set the default shell to zsh.
    };
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.darwin.apple_sdk.frameworks.Security
    pkgs.openconnect
    pkgs.fish
  ];

  nixpkgs.config.allowUnfree = true;
  security.pam.enableSudoTouchIdAuth = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  # nix.settings.experimental-features = "nix-command flakes";
  nix = {
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
      user = "perjohansson";
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
  environment.shells = [pkgs.zsh pkgs.fish];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

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
