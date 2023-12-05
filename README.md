# Initializers

# ArchLinux

## Install ArchLinux

```bash
loadkeys es
curl -L https://raw.githubusercontent.com/adriatp/initializers/main/arc/install.sh > install.sh
chmod 744 install.sh
./install.sh
> arc
> atp
> *********
> *********
> /dev/sda
# Hauria d'instalar yay
```

## Configure ArchLinux

### Clone initializers repository

```bash
git clone https://github.com/adriatp/initializers.git
cd initializers/arc
chmod 744 *.sh
```

### Nvidia drivers

```bash
./nvidia.sh
```

### Config

```bash
# Tota la configuracio s'executa a partir d'aqui
./config.sh
```
