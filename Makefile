# RHEL entitlement certificate and key files, required for building RHEL rpms and images.
RHEL_ENTCRT ?= $(shell ls /etc/pki/entitlement/*[0-9].pem 2> /dev/null | head -1)
RHEL_ENTKEY ?= $(shell ls /etc/pki/entitlement/*-key.pem 2> /dev/null | head -1)

.PHONY: c9s-rpms c9s-runner rhel9_8-rpms rhel9_8-runner

c9s-rpms:
	docker buildx build \
		-t qemu-kvm-rpms \
		-f Dockerfile.c9s.rpms \
		-o type=local,dest="./rpms" \
		.
c9s-runner:
	docker build \
		-t qemu-kvm-runner \
		-f Dockerfile.c9s.runner \
		.

rhel9_8-rpms:
	test -f "$(RHEL_ENTCRT)" && \
	test -f "$(RHEL_ENTKEY)" && \
	docker build \
		--secret id=entcrt,src=$(RHEL_ENTCRT) \
		--secret id=entkey,src=$(RHEL_ENTKEY) \
		-f Dockerfile.rhel9_8.rpms \
		-o type=local,dest="./rpms" \
		.

rhel9_8-runner:
	test -f "$(RHEL_ENTCRT)" && \
	test -f "$(RHEL_ENTKEY)" && \
	docker build \
		--secret id=entcrt,src=$(RHEL_ENTCRT) \
		--secret id=entkey,src=$(RHEL_ENTKEY) \
		-t qemu-kvm-runner \
		-f Dockerfile.rhel9_8.runner \
		.
