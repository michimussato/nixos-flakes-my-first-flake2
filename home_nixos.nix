{ lib, config, pkgs, ... }:

let
  shellAliases = {
    gs = "git status";
    ".." = "cd ..";
    ls = "ls -alh";
  };
  home-dir = "$HOME";
in

{

  # https://fnordig.de/til/nix/home-manager-allow-unfree.html
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        # deps for djv
        "openexr-2.5.10"
        "ilmbase-2.5.10"
      ];
    };
  };

  imports = [
    ./plasma_nixos.nix
  ];
  managedPlasma.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # pkgs.fzf
    pkgs.polychromatic
    pkgs.rawtherapee
    pkgs.darktable
    pkgs.gimp
    pkgs.gpodder
    pkgs.krita
    pkgs.handbrake
    pkgs.vlc
    pkgs.transmission_4-gtk
    pkgs.transmission-remote-gtk
    pkgs.spek
    pkgs.xournalpp
    pkgs.signal-desktop
    pkgs.djv
    pkgs.jetbrains.pycharm
    pkgs.podman-desktop
#    pkgs.devenv
#    pkgs.mpv
  ];

  programs.mpv = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };

#  programs.devenv = {
#    enable = true;
##    ZshIntegration = false;
##    FishIntegration = false;
##    NushellIntegration = false;
##    BashIntegration = true;
#  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # https://search.nixos.org/options?channel=26.05&query=programs.bash&type=options#show=option%253Aprograms.bash.enable
  programs.bash = {
    enable = true;
    inherit shellAliases;
  };

  # # https://search.nixos.org/options?channel=26.05&query=programs.bash&type=options#show=option%253Aprograms.bash.enable
  # programs.zsh = {
  #   enable = true;
  #   inherit shellAliases;
  #   # fastSyntaxHighlighting.enable = true;
  #   # oh-my-zsh.enable = true;
  # };

  # https://mynixos.com/search?q=fzf+home-manager
  programs.fzf = {
    # package = pkgs.fzf;
    enable = true;
    enableBashIntegration = true;
  };

  # https://mynixos.com/search?q=obs-studio+home-manager
  programs.obs-studio = {
    enable = true;
  };

  # https://wiki.nixos.org/wiki/Git#User-level_configuration_with_Home_Manager
  programs.git = {
    lfs.enable = true;
    enable = true;
    settings = {
      user = {
        email = "michimussato@etik.com";
        name = "Michael Mussato";
      };
      init.defaultBranch = "main";
    };
  };

  # https://mynixos.com/search?q=gitui+home-manager
  programs.gitui = {
    enable = true;
  };

  programs.calibre = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "default" = {
        id = 0;  # 0 is default
        path = "myprofile.default";
        search.default = "ddg";
        settings = {
          "browser.aboutConfig.showWarning" = false;
        };
        # bookmarks = [
        #   {
        #     name = "wikipedia";
        #     tags = [ "wiki" ];
        #     keyword = "wiki";
        #     url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
        #   }
        #   {
        #     name = "kernel.org";
        #     url = "https://www.kernel.org";
        #   }
        #   "separator"
        #   {
        #     name = "Nix sites";
        #     toolbar = true;
        #     # bookmarks = [
        #     #   {
        #     #     name = "homepage";
        #     #     url = "https://nixos.org/";
        #     #   }
        #     #   {
        #     #     name = "wiki";
        #     #     tags = [ "wiki" "nix" ];
        #     #     url = "https://wiki.nixos.org/";
        #     #   }
        #     # ];
        #   }
        # ];
      };
      # "test-default" = {
      #   id = 3;
      #   path = config.home.username;
      #   search.default = "ddg";
      #   settings = {
      #     "browser.aboutConfig.showWarning" = false;
      #   };
      # };
    };
  };

  services.flameshot = {
    enable = true;
    # https://mynixos.com/home-manager/option/services.flameshot.settings
    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
      };
    };
  };

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };

  home.file."${config.home.homeDirectory}/.face".source = ./payload/face_nixos.jpg;
  home.file."${config.xdg.configHome}/Pictures/Wallpapers" = {
    source = ./payload/Wallpapers;
    recursive = true;
  };


  # XDG User dirs: https://github.com/NixOS/nixpkgs/issues/33282
  xdg = {
    enable = true;
    userDirs.enable = true;
    # userDirs.setSessionVariables = true;
    userDirs.createDirectories = false;
    userDirs.extraConfig = {
      GIT = "${config.home.homeDirectory}/git";
      GIT_REPOS = "${config.home.homeDirectory}/git/repos";
      VENV = "${config.home.homeDirectory}/git/venv";
  #    XDG_GOOGLEDRIVE_DIR = "${home-dir}/GoogleDrive";
      KDRIVE = "${config.home.homeDirectory}/kDrive";
      WALLPAPERS = "${config.home.homeDirectory}/Pictures/Wallpapers";
    };
  };

  # https://mynixos.com/home-manager/option/home.activation
  home.activation = {
    myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # run ln -s $VERBOSE_ARG ${builtins.toPath ./link-me-directly} $HOME
    # /nix/store/s684h4kq0l8jdfsp5lsd46i3a7mwa9xq-source/link-me-directly
    run mkdir -p $HOME/kDrive;
    run mkdir -p $HOME/git/repos;
    run mkdir -p $HOME/git/venv;
    run mkdir -p $HOME/gPodder;
    run mkdir -p $HOME/gPodder;
    run mkdir -p $HOME/Documents/Obsidian;
    run mkdir -p $HOME/Calibre;
    run mkdir -p $HOME/VM/QEMU;
    run mkdir -p $HOME/VM/VirtualBox;
    run mkdir -p $HOME/VM/VMWare;

    run ln -s /data $HOME/ &> /dev/null || echo "~/data already exists"
    run ln -s ${builtins.toPath ./payload/Wallpapers} ${config.home.homeDirectory}/Pictures/ &> /dev/null || echo "~/Pictures/Wallpapers already exists"
    '';
  };

}
