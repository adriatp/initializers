# Initializers

## ArchLinux

### Install ArchLinux

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
```

### Configure ArchLinux

#### Clone initializers repository

```bash
git clone https://github.com/adriatp/initializers.git
```

#### Install yay (AUR) and drivers

```bash
cd initializers
chmod 744 arc/drivers.sh
./arc/drivers.sh
```

#### Install user applications and configure them

```bash
cd initializers
chmod 744 arc/config.sh
./arc/config.sh
```

### Update repo dotfiles with os dotfiles

```bash
cd initializers
chmod 744 arc/update_config.sh
./arc/update_config.sh
```
