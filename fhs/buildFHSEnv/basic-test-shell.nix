# https://aux-docs.pyrox.pages.gay/Nixpkgs/Build-Helpers/special/fhs-environments.section/
# nix-shell ./basic-test-shell.nix

{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "basic-test-shell";
  targetPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
    libX11
    libXcursor
    libXrandr
#  ]) ++ (with pkgs.xorg; [
#    libX11
#    libXcursor
#    libXrandr
  ]);
  multiPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
  ]);
  runScript = "bash";
}).env