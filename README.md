# Halo Custom Edition dedicated server as a container

Easily run `haloceded.exe` in a container (Docker) process!

## Usage

TODO: elaborate.

In short, assuming directory `$HALODIR` contains a `maps` and `data` directory, where the latter also has an `init.txt`:

```shell
podman run --init -d -i -t --rm \
  --name halo \
  -v $HALODIR/maps:/opt/app-root/maps \
  -v $HALODIR/data:/opt/app-root/data \
  -p 2302:2302/udp -p 2303:2303/udp \
  ghcr.io/alveel/haloceded-container:main
```

You can then detach by pressing Ctrl+p, then Ctrl+q. This will keep the process running in the background.

If you need to take control, run `podman attach halo` and after a few seconds you enter the console.

You can definitely just run it in daemon mode directly, and while that definitely works, I found that
for some reason, for every printed newline, you get two newlines, so the console gets fairly spammy.

TODO: I should probably add a compose file or something.

## Volume mounts

| Mount                | Description                                                                |
|----------------------|----------------------------------------------------------------------------|
| `/opt/app-root/maps` | Here (default & custom) maps must be mounted, including `bitmaps.map` etc. |
| `/opt/app-root/data` | init.txt, save games, and Gandanur configuration is stored here            |
| `/opt/app-root/logs` | For output logs                                                            |

## Notes

Inspired by several existing solutions that use pre-built Wine distributions:

- [docker-haloce-sapp](https://github.com/AugusDogus/docker-haloce-sapp) by AugusDogus
- [Halo CE dedicated server dockerized](https://github.com/antimomentum/haloce) by antimomentum

