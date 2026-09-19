# https://aux-docs.pyrox.pages.gay/Nixpkgs/Build-Helpers/special/fhs-environments.section/
# nix develop

{

  description = "Blender Dev Shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    pkgs-base = with pkgs; [
        # fhs shell
        (pkgs.buildFHSEnv {
          name = "fhs";
          runScript = "bash";
          targetPkgs = pkgs: (with pkgs; [
            udev
            alsa-lib
            libX11
            libXrender
            libXfixes
            libXi
            libxkbcommon
            libSM
            libICE
            libGL
            ]);
          }
         )
      ];
  in

  {
    devShells.x86_64-linux."base" = pkgs.mkShellNoCC {
      buildInputs = pkgs-base;
      shellHook = ''
        echo "You are now in a Blender configured environment."
        fhs
      '';
      env.TEST_VAR = "hello";
    };
    devShells.x86_64-linux."blender-3" = pkgs.mkShellNoCC {
      buildInputs = pkgs-base;
      shellHook = ''
        echo "You are now in a Blender 3 configured environment."
        fhs
      '';
      env.TEST_VAR = "hello";
    };
    devShells.x86_64-linux.blender-4 = pkgs.mkShellNoCC {
      buildInputs = pkgs-base;
      shellHook = ''
        echo "You are now in a Blender 4 configured environment."
        fhs
      '';
      env.TEST_VAR = "hello";
    };
    devShells.x86_64-linux.blender-5 = pkgs.mkShellNoCC {
      buildInputs = pkgs-base;
      shellHook = ''
        echo "You are now in a Blender 5 configured environment."
        fhs
      '';
      env.TEST_VAR = "hello";
    };
  };
}
