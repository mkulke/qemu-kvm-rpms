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
