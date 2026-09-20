<!-- TOC -->
* [Transition to NixOS](#transition-to-nixos)
  * [Install `nix` on Manjaro](#install-nix-on-manjaro)
  * [Learn `nix`](#learn-nix)
    * [NixOS](#nixos)
    * [Built Ins](#built-ins)
    * [Editor Setup](#editor-setup)
    * [Development Environments](#development-environments)
      * [devenv](#devenv)
        * [Cachix](#cachix)
    * [Experimental Features](#experimental-features)
    * [nix-community](#nix-community)
      * [Home Manager](#home-manager)
      * [Plasma Manager](#plasma-manager)
  * [Practical](#practical)
    * [Nix Config](#nix-config)
    * [Nix/NixOS Upgrade](#nixnixos-upgrade)
    * [Flakes](#flakes)
      * [flake-utils](#flake-utils)
      * [Starter Configs](#starter-configs)
<!-- TOC -->

---

# Transition to NixOS

- [x] [Install `nix` on Manjaro](#install-nix-on-manjaro)

## Install `nix` on Manjaro

Reference:
- https://nixos.org/download/#download-nix

```shell
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
```

## Learn `nix`

References:
- [Nix Language Explained](https://www.youtube.com/watch?v=UgrwoAGSPOQ)
- [Stop Guessing: Debug Your Nix Code Fast | Nix REPL](https://www.youtube.com/watch?v=swiWnAwionc)
- [MyNixOS](https://mynixos.com/)
- [garnix](https://github.com/garnix-io)
- [LibrePhoenix](https://www.youtube.com/@librephoenix)
- [Vimjoyer](https://www.youtube.com/@vimjoyer)
- [Ellyse](https://www.youtube.com/playlist?list=PL-oJWTgK9N6_tJ751N-TvhcF0aPu39zEY)
  - What is Gleam?

### NixOS

- [NixOS.org](https://nixos.org/)
  - Manuals
    - [Nix Manual](https://nixos.org/manual/nix/stable)
    - [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable)
    - [NixOS Manual](https://nixos.org/manual/nixos/stable)
  - [Search Packages](https://search.nixos.org/packages)
  - [Search Options](https://search.nixos.org/options)
- [Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://wiki.nixos.org/wiki/NixOS_Wiki)
  - [Cheat Sheet](https://wiki.nixos.org/wiki/Cheatsheet)
  - [Flakes](https://wiki.nixos.org/wiki/Flakes)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [nix.dev](https://nix.dev/)
  - [As PDF](https://nix.dev/nix-dev.pdf)

### Built Ins

Resources:
- [teu5us - Nix (builtins) & Nixpkgs (lib) Functions](https://teu5us.github.io/nix-lib.html)

### Editor Setup

References:
- [Easiest Way To Write Nix | Code Editor Setup](https://www.youtube.com/watch?v=M_zMoHlbZBY)
- [NixOS Development Environment/Shells for Programming](https://www.youtube.com/watch?v=yds4CZ5N_40)

### Development Environments

References:
- [NixOS Development Environment/Shells for Programming](https://www.youtube.com/watch?v=yds4CZ5N_40)
- [Michael Stapelberg - Development shells with Nix: four quick examples](https://michael.stapelberg.ch/posts/2025-07-27-dev-shells-with-nix-4-quick-examples/)
- [juliusunscripted - Configure a nix flake development shell](https://www.juliusunscripted.com/posts/configure-nix-flake-development-shell/)

#### devenv

References:
- [Devenv.sh: Instant Reproducible Dev Environments with Nix](https://www.youtube.com/watch?v=Oj9AxyiaVvU)

##### Cachix

- [Adding yourself to `trusted-users`](https://devenv.sh/binary-caching/#adding-yourself-to-trusted-users)
- [Devenv.sh, python and cachix questions](https://discourse.nixos.org/t/devenv-sh-python-and-cachix-questions/78151/9)

Todo:
- [ ] Cachix explanation

```nix
{
  # Is this actually needed?
  services.cachix-agent.enable = true;
  
  # Todo:
  # try with
  # nix.settings.trusted-users = [ "root" "@wheel" ];
  # instead of
  nix.settings.trusted-users = [
    "root"
    "nixos"
    # "michael"
  ];
}
```

### Experimental Features

References:
- [nix.dev - Experimental Features](https://nix.dev/manual/nix/2.35/development/experimental-features)
- [nix.dev - Configuration File](https://nix.dev/manual/nix/2.35/command-ref/conf-file#conf-experimental-features)

How to enable:
- temporarily:
  `nix --extra-experimental-features "nix-command flakes" <subcommand>`
- In `nix.conf`
  - `experimental-features = nix-command flakes`
- Enable with Env Var:
  Todo: is this even possible?
- in `configuration.nix`
  ```nix
  {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  }
  ```

### nix-community

- [nix-community](https://github.com/nix-community)
  - [Repositories](https://github.com/orgs/nix-community/repositories)
    - [awesome-nix](https://github.com/nix-community/awesome-nix)
    - [[home-manager](https://github.com/nix-community/home-manager)](#home-manager)
    - [[plasma-manager](https://github.com/nix-community/plasma-manager)](#plasma-manager)

#### Home Manager

https://github.com/nix-community/home-manager

#### Plasma Manager

https://github.com/nix-community/plasma-manager

Examples:
- [](https://github.com/nix-community/plasma-manager/blob/trunk/examples/systemFlake/flake.nix)

## Practical

### Nix Config

```shell
nix --extra-experimental-features "nix-command flakes" config show
```

### Nix/NixOS Upgrade

References:
- [Updating NixOS](https://wiki.nixos.org/wiki/Updating_NixOS)

- `nixos-rebuild switch --upgrade`
- `nixos-rebuild switch --flake <flake> --upgrade`

### Flakes

Resources:
- [nix.dev - `nix flake`](https://nix.dev/manual/nix/2.34/command-ref/new-cli/nix3-flake.html#self-attributes1)
- [Zero to Nix - Nix flakes](https://zero-to-nix.com/concepts/flakes/)

Todo:
- [ ] Investigate flakes with references to Git LFS
  tracked contents.
  - [git-lfs/git-lfs](https://github.com/git-lfs/git-lfs?utm_source=gitlfs_site&utm_medium=installation_link&utm_campaign=gitlfs#example-usage)
  - [Github Docs - Configuring Git Large File Storage](https://docs.github.com/en/repositories/working-with-files/managing-large-files/configuring-git-large-file-storage)
  - [Self-attributes](https://nix.dev/manual/nix/2.34/command-ref/new-cli/nix3-flake.html#self-attributes)
    ```nix
    {
      inputs = {
        self.lfs = true;
      };
    }
    ```
- [ ] How can we stop referencing things like:
  - `boot.loader.grub.device`
  - `boot.kernelPackages`
  - `...`
  in `configuration.nix`
  - `hardware-configuration.nix`
  in flake?
- [ ] How to use/treat/provide secrets?
- [ ] sddm: How to set avatars
  - https://www.reddit.com/r/NixOS/comments/1cot084/is_there_way_to_make_sddm_to_display_users_avatars/

#### flake-utils

Todo:
- [ ] understand `flake-utils`
```nix
{
  inputs = {
    # - https://michael.stapelberg.ch/posts/2025-07-27-dev-shells-with-nix-4-quick-examples/
    flake-utils.url = "github:numtide/flake-utils";
  };
}
```

#### Starter Configs

https://github.com/Misterio77/nix-starter-configs
