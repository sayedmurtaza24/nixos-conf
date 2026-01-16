{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

	  inputs.lanzaboote.nixosModules.lanzaboote

	  ({ pkgs, lib, ... }: {
            environment.systemPackages = [
              pkgs.sbctl
	    ];

	    boot.loader.systemd-boot.enable = lib.mkForce false;

	    boot.lanzaboote = {
              enable = true;
	      pkiBundle = "/var/lib/sbctl";
	    };
	  })
        ];
      };
    };
  };
}
