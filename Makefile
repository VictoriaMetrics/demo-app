CONTAINER_TOOL ?= docker
REGISTRY ?= docker.io
ORG ?= victoriametrics
REPO = demo-app
KIND_CLUSTER_NAME ?= kind
TAG ?= $(shell echo $$(git describe --long --all | tr '/' '-')$$( \
	git diff-index --quiet HEAD -- || echo '-dirty-'$$( \
		git diff-index -u HEAD -- ':!config' ':!docs' | openssl sha1 | cut -d' ' -f2 | cut -c 1-8)))

.PHONY: docker-build
docker-build:
	$(CONTAINER_TOOL) build -t $(REGISTRY)/$(ORG)/$(REPO):$(TAG) .

.PHONY: docker-push
docker-push:
	$(CONTAINER_TOOL) push $(REGISTRY)/$(ORG)/$(REPO):$(TAG)

load-kind: docker-build
	kind load docker-image $(REGISTRY)/$(ORG)/$(REPO):$(TAG) --name=$(KIND_CLUSTER_NAME);