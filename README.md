# Demo app

Demo application showcasing features like metrics exposition, ... .

## Deploy

```
TAG=1.0 make docker-build;
TAG=1.0 make docker-push;
```

## Load image to kind cluster

```
make kind-load
```

## Multi-platform build

```
docker buildx create --use --name=qemu
docker buildx inspect --bootstrap  

TAG=1.2 make docker-build-multi-platform;
```
