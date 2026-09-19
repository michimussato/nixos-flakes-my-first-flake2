

---

```shell
sudo pacman -S git-lfs
# https://docs.github.com/en/repositories/working-with-files/managing-large-files/configuring-git-large-file-storage
# https://github.com/git-lfs/git-lfs?utm_source=gitlfs_site&utm_medium=installation_link&utm_campaign=gitlfs#example-usage
git lfs track "*.png"
```

> [!WARNING]
> 
> Tip: if you have large files already in your 
> repository's history, git lfs track will not 
> track them retroactively. To migrate existing 
> large files in your history to use Git LFS, 
> use git lfs migrate. For example:
> 
> ```shell
> git lfs migrate import --include="*.png" --everything
> ```
> 
> Note that this will rewrite history and change 
> all of the Git object IDs in your repository, 
> just like the export version of this command.
> 
> convert back to normal non-LFS repo:
> ```shell
> git lfs migrate export --include="*.png" --everything
> ```

Nix flakes:
- https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/inputs
- https://github.com/NixOS/nix/issues/15285