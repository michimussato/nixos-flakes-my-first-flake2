```shell
scp -r -P 2222 nixos@localhost:/home/nixos/flakes /home/michael/git/repos/nixos-configuration/configs/flakes/LibrePhoenix
```


rsync `host` -> `guest`
```shell
rsync \
    -e "ssh -p 2222" \
    -rhav \
    --progress \
    /home/michael/git/repos/nixos-configuration/configs/flakes/LibrePhoenix/flakes/ \
    nixos@localhost:/home/nixos/flakes \
    
```

rsync `guest`-> `host`
```shell
rsync \
    -e "ssh -p 2222" \
    -rhav \
    --progress \
    nixos@localhost:/home/nixos/flakes/ \
    /home/michael/git/repos/nixos-configuration/configs/flakes/LibrePhoenix/flakes/ \
    
```

rsync `guest`-> `host`
```shell
rsync \
    -e "ssh -p 2222" \
    -rhav \
    --progress \
    nixos@localhost:/home/nixos/flakes/flake.lock \
    /home/michael/git/repos/nixos-configuration/configs/flakes/LibrePhoenix/flakes/ \
    
```

