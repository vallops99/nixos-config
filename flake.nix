{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-generators,
      ...
    }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.vallops = import ./home.nix;
            }
          ];
        };
        # iso = nixpkgs.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   modules = [
        #     "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        #     ./configuration.nix
        #     home-manager.nixosModules.home-manager
        #     {
        #       isoImage.makeEfiBootable = true;
        #       isoImage.makeUsbBootable = true;
        #     }
        #     {
        #       home-manager.useGlobalPkgs = true;
        #       home-manager.useUserPackages = true;

        #       home-manager.users.vallops = import ./home.nix;
        #     }
        #   ];
        # };
      };

      packages.x86_64-linux.iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vallops = import ./home.nix;
          }
        ];
        format = "iso";
      };
    };
}
