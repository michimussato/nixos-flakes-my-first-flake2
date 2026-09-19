

---

# Python on NixOS

- https://www.youtube.com/watch?v=6fftiTJ2vuQ

## devenv

- https://devenv.sh/languages/python/
- https://discourse.nixos.org/t/devenv-sh-python-and-cachix-questions/78151/11

```shell
devenv init
devenv shell --verbose  # --trace-to pretty:stdout
```

```shell
devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs
```