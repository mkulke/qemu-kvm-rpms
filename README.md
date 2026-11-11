# qemu-kvm RPMs

This repo is used to build custom qemu-kvm RPMS for CentOS Stream and RHEL in a containerized environment. Patches that are places in the `patches` folder are applied as specified explicitly in the respective Dockerfiles.

There are also Dockerfiles to produce a runner image, which can used to launch a guest VM with the previously built RPMs in a container.

## RPMs

### CentOS Stream 9

```bash
make c9s-rpms
```

### RHEL 9.8

For RHEL builds we need a valid suscription for RHEL in the form of an entitlement certificate and key in `/etc/pki/entitlement`.

```bash
make rhel9_8-rpms
```

## Runner

The runner launches into a HMP console. Tail `logs/serial.log` in another shell. Use `ssh cloud@localhost -p 2222` (p/w `cloud123`) to log in to the guest.

### CentOS Stream 9

```bash
make c9s-runner
sudo docker run --rm -it --privileged \
    -v /dev/mshv:/dev/mshv \
    -v $PWD/logs:/var/run/qemu/logs \
    -p 2222:2222 \
    qemu-kvm-runner
```

### RHEL 9.8

```bash
make rhel9_8-runner
sudo docker run --rm -it --privileged \
    -v /dev/mshv:/dev/mshv \
    -v $PWD/logs:/var/run/qemu/logs \
    -p 2222:2222 \
    qemu-kvm-runner
```
