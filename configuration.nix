# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

let
  # Define the custom background package with the correct relative path
  # background-package = pkgs.runCommand "background-image" {} ''
  #   cp ${./payload/Wallpapers/nploschenko_rain_drops.png} $out
  # '';
  sddm-background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "sddm-background-image";
    src = ./payload/Wallpapers/nploschenko_rain_drops.png;  # Place wallpaper.jpg in the same directory as this config file
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
  };
in

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.qemu.nix
    # Packages
  ];

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "@wheel" ];

#  # https://nixos.wiki/wiki/Nvidia
#  # 1. https://nixos.wiki/wiki/Nvidia#Modifying_NixOS_Configuration
#  # 2. https://nixos.wiki/wiki/Nvidia#Laptop_Configuration:_Hybrid_Graphics_(Nvidia_Optimus_PRIME)
#  # nix-shell -p lshw --command sudo lshw -c display
#  # Enable OpenGL
#  hardware.graphics = {
#    enable = true;
#  };
#
#  # Load nvidia driver for Xorg and Wayland
#  services.xserver.videoDrivers = ["nvidia"];
#
#  hardware.nvidia = {
#
#    # Modesetting is required.
#    modesetting.enable = true;
#
#    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
#    # Enable this if you have graphical corruption issues or application crashes after waking
#    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
#    # of just the bare essentials.
#    powerManagement.enable = false;
#
#    # Fine-grained power management. Turns off GPU when not in use.
#    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
#    powerManagement.finegrained = false;
#
#    # Use the NVidia open source kernel module (not to be confused with the
#    # independent third-party "nouveau" open source driver).
#    # Support is limited to the Turing and later architectures. Full list of
#    # supported GPUs is at:
#    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
#    # Only available from driver 515.43.04+
#    open = false;
#
#    # Enable the Nvidia settings menu,
#	# accessible via `nvidia-settings`.
#    nvidiaSettings = true;
#
#    # Optionally, you may need to select the appropriate driver version for your specific GPU.
#    package = config.boot.kernelPackages.nvidiaPackages.stable;
#  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-qemu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # - https://forum.manjaro.org/t/cant-change-background-of-sddm/144466
  # - https://discourse.nixos.org/t/sddm-background-on-default-theme/46263
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    theme = "breeze";
  };
  services.desktopManager.plasma6.enable = true;

  # home.file."${config.home.homeDirectory}/.face".source = ./payload/face_nixos.jpg;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nixos" = {
    # hashedPasswordFile = "/etc/passwd";
    initialPassword = "nixos";
    isNormalUser = true;
    description = "NixOS Sandbox User";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  users.users."michael" = {
    # hashedPasswordFile = "/etc/passwd";
    initialPassword = "michael";
    isNormalUser = true;
    description = "Michael Mussato";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  users.mutableUsers = false;
  # evaluation warning: The user 'michael' has multiple of the options
  #                    `initialHashedPassword`, `hashedPassword`, `initialPassword`, `password`
  #                    & `hashedPasswordFile` set to a non-null value.
  #
  #                    If multiple of these password options are set at the same time then a
  #                    specific order of precedence is followed, which can lead to surprising
  #                    results. The order of precedence differs depending on whether the
  #                    {option}`users.mutableUsers` option is set.
  #
  #                    If the option {option}`users.mutableUsers` is
  #                    `true`, then the order of precedence is as shown
  #                    below, where values on the left are overridden by values on the right:
  #                    {option}`initialHashedPassword` -> {option}`initialPassword` -> {option}`hashedPassword` -> {option}`password` -> {option}`hashedPasswordFile`
  #
  #                    The values of these options are:
  #                    * users.users."michael".hashedPassword: null
  #                    * users.users."michael".hashedPasswordFile: "/etc/passwd"
  #                    * users.users."michael".password: null
  #                    * users.users."michael".initialHashedPassword: null
  #                    * users.users."michael".initialPassword: "michael"

  # Install firefox.
  # leave this enabled so that we always have
  # a browser to work with
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
    git
    tree
    dnsutils
    htop
    btop
    lshw
    rsnapshot
    rclone
    gparted
    ffmpeg
    qemu_full
    docker
    podman
    podman-compose
    podman-tui
    devenv
    # nvidia-container-toolkit
    # This defines a custom global sddm background image
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background="${sddm-background-package}"
      type=image
    '')
  ];

  # # Shells
  # environment.shells = with pkgs; [
  #   bash
  #   zsh
  # ];
  # users.defaultUserShell = pkgs.bash;
  # environment.pathsToLink = [ "/share/bash-completion" ];
  # programs.zsh.enable = true;
  # environment.pathsToLink = [ "/share/zsh" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # also available for home manager
  services.cachix-agent.enable = true;

  # also available for home manager
  services.teamviewer.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  # Enable experiemental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # devenv
  # - https://discourse.nixos.org/t/devenv-sh-python-and-cachix-questions/78151/11
  # - https://devenv.sh/binary-caching/#adding-yourself-to-trusted-users
  # nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.trusted-users = [
    "root"
    "nixos"
    # "michael"
  ];

  # Create basic default directories:
  # - https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
  # - https://search.nixos.org/options?channel=26.05&query=systemd.tmpfiles&type=options#show=option%253Asystemd.tmpfiles.rules
  systemd.tmpfiles = {
    rules = [
      # create the directory /data
      "d	/data	0777	root	root	-	-"
      # set chattr +i on /data
      "h	/data	-	-	-	-	+i"
    ];
  };

  # Only enable either docker or podman -- Not both
  # - https://github.com/Sly-Harvey/NixOS/blob/master/modules/core/virtualisation.nix
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    podman = {
      enable = false;
    };
  };
  # error:
  # Failed assertions:
  # - `nvidia-container-toolkit` requires nvidia drivers: set
  #   `hardware.nvidia.datacenter.enable`, add "nvidia" to
  #   `services.xserver.videoDrivers`, or set
  #   `hardware.nvidia-container-toolkit.suppressNvidiaDriverAssertion`
  #   if the driver is provided by another NixOS module (e.g. from NixOS-WSL)
  # hardware.nvidia.datacenter.enable = true;
  # hardware.nvidia-container-toolkit = {
  #   enable = true;
  #   suppressNvidiaDriverAssertion = true;
  # };

  # This might be replace with Syncthing at some point
  # mount.nfs: access denied by server while mounting 192.168.178.15:/data
  # journalctl -fu nfs-mountd
  # refused mount request from 192.168.178.195 for /data (/data): illegal port 45999
  # showmount -e miniboss.meemoo.lan
  # https://askubuntu.com/a/1526224
  # Try this from VirtualBox?
  # - [x] tested
  # - [x] works
  # - [ ] make sure the system works even if the mount fails
  fileSystems."/data" = {
    # sudo systemctl status data.mount
    device = "miniboss.meemoo.lan:/data";
    fsType = "nfs4";
    options = [
      # "nfsvers=4.2"  # if not specified, this (port >1024) could be an issue: https://serverfault.com/a/1123618
      "auto"
      "nofail"
      "noatime"
      "nolock"
      # "intr"
      "tcp"
      "actimeo=1800"
    ];
  };

}
