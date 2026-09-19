# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, config, pkgs, ... }:

{

  options = {
    pkg_pycharm.enable = lib.mkEnableOption "Enables PyCharm";
  };

  config = lib.mkIf config.pkg_pycharm.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.pycharm
      git
    ];
  };
}
