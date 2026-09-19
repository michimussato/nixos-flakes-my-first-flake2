# A Derivation
{ pkgs ? import <nixpkgs> {} }:

(
	pkgs.buildFHSEnv {
		name = "basic-fhs";
		runScript = "bash";
		targetPkgs = pkgs: with pkgs; [
			neovim
		];
	}
)
