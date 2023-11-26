# Initializers

## Install ArchLinux
```bash
loadkeys es
curl -L https://raw.githubusercontent.com/adriatp/initializers/main/arc/install.sh > install.sh
chmod 777 install.sh
./install.sh
```

## Install drivers

```bash
curl -L https://raw.githubusercontent.com/adriatp/initializers/main/arc/nvidia.sh > nvidia.sh
chmod 777 nvidia.sh
./nvidia.sh
```

## TODO

- [ ] Allow install nvidia drivers from archiso
- [ ] Avoid password prompt for sudo commands in nvidia drivers installation