# Initializers

## Install ArchLinux
```bash
loadkeys es
systemd-resolve --flush-caches
curl -L https://raw.githubusercontent.com/adriatp/initializers/main/arc/install.sh | sh
reboot
```

## Install drivers

```bash
curl -L https://raw.githubusercontent.com/adriatp/initializers/main/arc/nvidia.sh | sh
```

## TODO

- [ ] Allow install nvidia drivers from archiso
- [ ] Avoid password prompt for sudo commands in nvidia drivers installation