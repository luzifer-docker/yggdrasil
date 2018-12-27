# luzifer-docker / yggdrasil

Run [Yggdrasil](https://yggdrasil-network.github.io/) node in a Docker container

## Usage

```bash
## Build container (optional)
$ docker build -t luzifer/yggdrasil .

## Create config and action file (if you don't the config will be
## generated on first run)
$ tree
.
└── yggdrasil.conf

0 directories, 2 files

## Execute yggdrasil node
$ docker run --rm -ti --net=host --cap-add=NET_ADMIN --device=/dev/net/tun -v $(pwd):/config luzifer/yggdrasil
```
