# https://aux-docs.pyrox.pages.gay/Nixpkgs/Build-Helpers/special/fhs-environments.section/
# nix develop

# https://aux-docs.pyrox.pages.gay/Nixpkgs/Build-Helpers/special/fhs-environments.section/
# nix-shell ./blender-shell.nix

{

  description = "Nuke Dev Shells";

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
        # name = "houdini-${unwrapped.version}";

        # # houdini spawns hserver (and other license tools) that is supposed to live beyond the lifespan of houdini process
        # dieWithParent = false;

        # # houdini needs to communicate with hserver process that it seem to be checking to be present in running processes
        # unsharePid = false;
        targetPkgs = pkgs: (with pkgs; [
          # This could probably need some cleanup
          bash
          ncurses5

          libgssglue
          libkrb5

          glib
          libxcrypt-legacy

          libGLU
          libGL
          alsa-lib
          fontconfig
          zlib
          libpng
          dbus
          nss
          nspr
          expat
          pciutils
          libxkbcommon
          libudev0-shim
          tbb
          xwayland
          qt5.qtwayland
          nettools  # needed by licensing tools
          bintools  # needed for ld and other tools, so ctypes can find/load sos from python
          ocl-icd  # needed for opencl
          numactl  # needed by hfs ocl backend
          zstd  # needed from 20.0

          libice
          libsm
          libxmu
          libxi
          libxext
          libx11
          libxrender
          libxcursor
          libxfixes
          libxcomposite
          libxdamage
          libxtst
          libxcb
          libxscrnsaver
          libxrandr
          libxcb-util
          libxcb-image
          libxcb-render-util
          libxcb-cursor
          libxcb-keysyms
          libxcb-wm

        ]);
      })
    ];
  in

  {
    devShells."${system}" = {

      nuke-base = pkgs.mkShellNoCC {
        buildInputs = pkgs-base;
        # extraBwrapArgs = [
        #   "--ro-bind-try /run/opengl-driver/etc/OpenCL/vendors /etc/OpenCL/vendors" # this is the case of NixOS
        #   "--ro-bind-try /etc/OpenCL/vendors /etc/OpenCL/vendors" # this is the case of not NixOS
        # ];
    #    runScript = "bash";
        # runScript = pkgs.writeScript "houdini-wrapper" ''
        #   # ncurses5 is needed by hfs ocl backend
        #   # workaround for this issue: https://github.com/NixOS/nixpkgs/issues/89769
        #   export LD_LIBRARY_PATH=/nix/store/qz68yx7v9zcpq490y6sb83v2dvygj4cr-ncurses-abi5-compat-6.6/lib:$LD_LIBRARY_PATH
        #   exec "$@"
        # '';
        # set the environment variables that Qt apps expect
        shellHook = ''
          echo "You are now in a Nuke configured environment."
          fhs
        '';
        # Custom Env:
        # env.MY_CUSTOM_VAR = "custom value";
        env.foundry_LICENSE = "5053@miniboss.meemoo.lan";
      };
    };
  };
}
