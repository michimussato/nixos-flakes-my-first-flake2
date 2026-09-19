{

  description = "My first flake";

  inputs = {
    # https://nix.dev/manual/nix/2.34/command-ref/new-cli/nix3-flake.html#self-attributes1
    # self.submodule = false;
    # Was not able to confirm that this actually works
    self.lfs = true;  # because Wallpapers are tracked with LFS

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # # plasma-manager
    # # - https://github.com/nix-community/plasma-manager/blob/trunk/examples/systemFlake/flake.nix
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    shells-blender = {
      url = "path:./fhs/buildFHSEnv/blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
#      insecureNixPkg = import <nixos> {
#        config = {
#          permittedInsecurePackages = [
#            "openexr-2.5.10"
#            "ilmbase-2.5.10"
#          ];
#        };
#      };
    in {
#    home.packages = with pkgs; [
#      insecureNixPkg.kdePackages.neochat
#    ];

    devShells = inputs.shells-blender.devShells;

    nixosConfigurations = {
      # This ideally reflects a hostname (but that's not a requirement)
      nixos-qemu = lib.nixosSystem {
        inherit system;
#        inherit insecureNixPkg;
        modules = [
          ./configuration.nix
        ];
      };
    };
    # home-manager
    homeConfigurations = {
      # This reflects the user name
      nixos = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
#        inherit insecureNixPkg;
        modules = [
          # ./plasma_nixos.nix
          inputs.plasma-manager.homeModules.plasma-manager
          ./home_nixos.nix
        ];
      };
    };
  };

}
