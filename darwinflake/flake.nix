{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
    let
      configuration = { pkgs, ... }: {
        homebrew.enable = true;
        homebrew.brews = [ "mas" ];
        homebrew.casks = [ "brave-browser" "kitty" "visual-studio-code" "bloomrpc" "rectangle" "bitwarden" "docker" ];
        homebrew.masApps = { Flycut = 442160987; };
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.vim
            pkgs.darwin.apple_sdk.frameworks.Security
            pkgs.openconnect
            pkgs.fish
          ];

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
        };
        environment.shells = [ pkgs.zsh pkgs.fish ];

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;
        users.users.perjohansson = {
          home = "/Users/perjohansson";
          shell = pkgs.zsh;
        };

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
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
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Pers-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          inputs.home-manager.darwinModules.home-manager
          {
            # nixpkgs = nixpkgsConfig;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.perjohansson = import ./home.nix;

          }

        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."simple".pkgs;
    };
}
