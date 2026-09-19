

How to use this flake:
1. Install OS
2. Reboot
3. Edit `configuration.nix`
   1. ```nix
      {
        # Enable experimental Features
        nix.settings.experimental-features = [
          # for `nix run`
          "nix-command"
          "flakes"
        ];
      }
      ```
   2. set hostname: `nixos-qemu`
   3. ideally enable SSH
4. `nixos-rebuild --sudo switch`
5. Install `home-manager` & `plasma-manager`
   ```shell
   nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
   nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   # add to `.profie`: '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"'
   # build test: home-manager build --flake github:michimussato/nixos-flakes-my-first-flake2#nixos -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
   # home-manager switch --flake github:michimussato/nixos-flakes-my-first-flake2#nixos -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
   ```
6. Install flake
   1. `nixosConfigurations`
      ```shell
      # better clone locally for now:
      # git clone https://github.com/michimussato/nixos-flakes-my-first-flake2.git
      # cd nixos-flakes-my-first-flake2
      # nixos-rebuild --sudo switch --flake .#nixos-qemu -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
      sudo nixos-rebuild switch --flake github:michimussato/nixos-flakes-my-first-flake2#nixos-qemu --verbose
      # nixos-rebuild --sudo switch --flake .#nixos-qemu -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
      # [ ] sddm background not visible
      #     - reference to `version https://git-lfs.github.com` in package file seems correct
      ```
   2. `homeConfigurations`
      ```shell
      home-manager switch --flake github:michimussato/nixos-flakes-my-first-flake2#nixos -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
      ```





Create flake:
```shell
nix --experimental-features "nix-command flakes" flake init
```

Flakes need to be tracked
```shell
nix-shell -p git
git init --initial-branch=main
git config user.email "michimussato@etik.com"
git config user.name "Michael Mussato"
git add flake.nix
exit
```

Execute flake
```shell
nix --experimental-features "nix-command flakes" run path:./flake.nix
```

Rebuild system from flake:
```shell
nixos-rebuild switch --flake .
```

Creates `flake.lock`
Update `flake.lock`
```shell
nix --experimental-features "nix-command flakes" flakes update
```

Globally enable experimental features:
```nix
{
  # Enable experimental Features
  nix.settings.experimental-features = [
  	# for `nix run`
    "nix-command"
    "flakes"
  ];
}
```

[Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)

```shell
nix flake init --template github:misterio77/nix-startet-config#standard
# edit flake.nix  # => FIXMEs
# keep ./nixos/configuration.nix
# but change ./hardware-configuration.nix
git add -A
# --impure because access to absolute path /etc/nixos/configuration.nix is forbidden in pure evaluation mode
# --log-format https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-log#opt-log-format
sudo nixos-rebuild switch --flake .#<hostname> --impure
```

Reset to default (leave flake?):
```shell
sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix
```

https://wiki.nixos.org/wiki/Flakes#See_also

download buffer is full; consider increasing the 'download-buffer-size' setting

---

```shell
NUKE="Nuke15.2v9-linux-x86_64"
tar -tf ${NUKE}.tgz
# tar -xOzvf ${NUKE}.tgz ${NUKE}.run | bash ${NUKE}.run --accept-foundry-eula
tar -xzvf ${NUKE}.tgz
# chmod +x ${NUKE}.run
bash ${NUKE}.run --accept-foundry-eula --prefix=./Nuke
rm ${NUKE}.tgz
rm ${NUKE}.run
```

---

# RnD

Install flake in Qemu VM:
```shell
# Test:
# sudo nixos-rebuild build-vm --flake github:michimussato/nixos-flakes-my-first-flake2#nixos-qemu --verbose
# result/bin/run-*-vm
# 
sudo nixos-rebuild boot --flake github:michimussato/nixos-flakes-my-first-flake2#nixos-qemu -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
sudo nixos-rebuild switch --upgrade --flake github:michimussato/nixos-flakes-my-first-flake2#nixos-qemu -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
```

- https://nixos.asia/en/nixos-install-flake
- https://discourse.nixos.org/t/how-to-get-nixos-install-flake-to-work/10069

---

Install home-manager/plasma-manager

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager
nix-channel --update
nix-shell '<home-manager>' -A install
# . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
home-manager build --flake github:michimussato/nixos-flakes-my-first-flake2#nixos -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
home-manager switch --upgrade --flake github:michimussato/nixos-flakes-my-first-flake2#nixos -b $(date +"%Y-%m-%d_%H-%M-%S") --verbose
```

Get nix store path:
- https://stackoverflow.com/questions/56622933/how-to-find-a-derivation-path-in-the-store-starting-from-the-compiled-package-p