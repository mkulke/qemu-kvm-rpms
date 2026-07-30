c9s:
	docker buildx build \
		-t qemu-kvm-rpms \
		-f Dockerfile.c9s \
		-o type=local,dest="./rpms" \
		.
