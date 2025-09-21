{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Official DankMaterialShell flake
    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri flake - required even if not using niri HM module due to DMS dependency
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, niri, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # or "aarch64-linux" if you're on ARM
        specialArgs = { inherit inputs; }; # Pass inputs to configuration
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.murtaza = import ./home.nix;

            # Add overlays for packages
            nixpkgs.overlays = [
              # Make niri available if needed
              (final: prev: {
                niri = niri.packages.${prev.system}.niri;
              })
            ];
          }
        ];
      };
    };
  };
}
