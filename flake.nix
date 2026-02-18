{
  description = "stupid flaek";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass inputs into modules
      specialArgs = { inherit self nixpkgs home-manager; };

      modules = [
        ./configuration.nix
        ./greetd.nix

        # Integrate Home Manager into the system
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nexus = import ./home.nix;
        }
      ];
    };
  };
}
