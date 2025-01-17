{
  description = "Example Darwin system flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nixvim.url = "github:nix-community/nixvim";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # linux-builder.url = "path:/Users/perjohansson/nixfiles/darwinflake/linuxbuilder";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    mac-app-util,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Pers-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/mac/configuration.nix
        # configuration
        inputs.home-manager.darwinModules.home-manager
        # linux-builder.darwinConfigurations.machine1
        {
          # nixpkgs = nixpkgsConfig;
          home-manager.sharedModules = [
            mac-app-util.homeManagerModules.default
          ];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.perjohansson = import ./home.nix;
        }
      ];
    };
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-x86/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = ".bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.perj = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = ".bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.perj = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
