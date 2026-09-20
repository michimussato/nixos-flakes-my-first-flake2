{

  description = "My first flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # shells-blender = {
    #   url = "path:./fhs/buildFHSEnv/blender";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # shells-houdini = {
    #   url = "path:./fhs/buildFHSEnv/houdini";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # shells-nuke = {
    #   url = "path:./fhs/buildFHSEnv/nuke";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, ... }:

    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    nixosConfigurations = {
      # This ideally reflects a hostname (but that's not a requirement)
      nixos-qemu = lib.nixosSystem {
        inherit system;
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
        modules = [
          inputs.plasma-manager.homeModules.plasma-manager
          ./home_nixos.nix
        ];
      };
    };
  };

}
