```shell
sudo nixos-rebuild boot --flake .#nixos-qemu
[sudo] password for nixos: 
building the system configuration...
Checking switch inhibitors... done
updating GRUB 2 menu...
Warning: os-prober will be executed to detect other bootable partitions.
Its output will be used to detect bootable binaries on them and create new boot entries.
lsblk: /dev/mapper/no*[0-9]: No such file or directory
lsblk: /dev/mapper/raid*[0-9]: No such file or directory
lsblk: /dev/mapper/disks*[0-9]: No such file or directory
Found Manjaro Linux (26.1.2) on /dev/nvme0n1p2
installing the GRUB 2 boot loader on /dev/sda...
Installing for i386-pc platform.
/nix/store/nxgbnri4sklbwvy3axg2grcpfnsnh2ja-grub-2.12/sbin/grub-install: warning: this GPT partition label contains no BIOS Boot Partition; embedding won't be possible.
/nix/store/nxgbnri4sklbwvy3axg2grcpfnsnh2ja-grub-2.12/sbin/grub-install: warning: Embedding is not possible.  GRUB can only be installed in this setup by using blocklists.  However, blocklists are UNRELIABLE and their use is discouraged..
/nix/store/nxgbnri4sklbwvy3axg2grcpfnsnh2ja-grub-2.12/sbin/grub-install: error: will not proceed with blocklists.
/nix/store/4a604qygv60yx8va345h69dc776367jn-install-grub.pl: installation of GRUB on /dev/sda failed: No such file or directory
Failed to install bootloader
Command 'systemd-run -E LOCALE_ARCHIVE -E NIXOS_INSTALL_BOOTLOADER -E NIXOS_NO_CHECK --collect --no-ask-password --pipe --quiet --service-type=exec --unit=nixos-rebuild-switch-to-configuration /nix/store/68lklnkwxp2cd5xxdshw9j4dkzil01xg-nixos-system-nixos-26.05.20260916.4c78701/bin/switch-to-configuration switch' returned non-zero exit status 1.
```
