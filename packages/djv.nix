# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, config, pkgs, ... }:

{

  options = {
    pkg_djv.enable = lib.mkEnableOption "Enables djv Image Sequence Player";
  };

  config = lib.mkIf config.pkg_djv.enable {
    environment.systemPackages = with pkgs; [
      djv
    ];

    nixpkgs.config.permittedInsecurePackages = [
      # deps for djv
      "openexr-2.5.10"
      "ilmbase-2.5.10"
    ];
  };
}
