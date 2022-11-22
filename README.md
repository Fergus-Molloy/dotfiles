# dotfiles

repo for storing my dotfiles. Utilises GNU stow for managing these files from a central location.

To use simply ensure the config file you want to use doesn't already exist and then run `stow <module_name>` to automatically setup a symlink to this repo.

To add a new config to this repo ensure the folder structure is correct and then move the config into this repo. You can then use stow to symlink to the original location.

The folder structure should look as follows

`dotfiles/<module_name>/path/from/home/to/file/config`

By running `stow <module_name>` from the dotfiles directory the file `config` would end up at `~/path/from/home/to/file/config`

# Arch Install Instructions

## setup keyboard
```bash
loadkeys uk
```
## connect to the internet
```bash
iwctl station wlan0 connect "..." --passphrase "..."
ping www.google.com
```
## set date and time
```bash
timedatectl status
```
## partition disk
1. +512M type 1
2. The rest of the drive default type
```bash
fdisk /dev/...
```
## make file system
```bash
mkfs.fat -F 32 /dev/...1
mkfs.btrfs /dev/...2
```
## mount partitions
```bash
mount /dev/...2 /mnt
mount --mkdir /dev/...1 /mnt/boot/efi
```
If dual booting mount windows
```bash
mount --mkdir /dev/... /mnt/win11
```
## update mirrors
(if skipped to this step make sure you connect to the internet)
```bash
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
```
## install the system
```bash
pacstrap -K /mnt base linux linux-firmware vim networkmanager zsh git
```
## genfstab
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```
## change root
```bash
arch-chroot /mnt
```
## setup locales
edit `/etc/locale.gen` and uncomment `en_GB.UTF-8` line
```bash
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf"
echo "KEYMAP=uk" > /etc/vconsole.conf
```
## Configure hostname
```bash
echo "<hostname>" > /etc/hostname
```
edit `/etc/hosts` to be the following:
```
127.0.0.1   localhost
::1         localhost
127.0.1.1   <hostname>
```
## root password
```bash
passwd
```
## new user
```bash
useradd -m fergus -G wheel -s /usr/bin/zsh
passwd fergus
```
## setup boot loader
```bash
pacman -Syu && pacman -S grub efibootmgr
```
if dual booting then
```bash
pacman -S os-prober ntfs-3g
```
if dual booting then edit `/etc/default/grub` and uncomment the line disabling os prober (normally the bottom line)

## install the bootloader
```bash
grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```
don't worry if os-prober doesn't find windows might need to do that after reboot.

Now our system should be good to reboot so shutdown and remove the installation media

# Post reboot
login as `fergus` using the set password
## connect to internet (again)
```bash
nmcli device wifi connect "..." password "..."
```
## install paru
install deps first
```bash
pacman -S --needed base-devel
pacman -S rustup
```
set up rust
```bash
rustup toolchain install stable # maybe install nightly too
rustup default set stable
```
```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
## system update
```bash
paru -Syu
```
## setup dotfiles
```bash
git clone https://github.com/Fergus-Molloy/dotfiles.git .dotfiles
cd .dotfiles
git switch stow
stow ... # all the dotfiles you want setup
```

## Install WM
```bash
paru -S i3-gaps lightdm lightdm-gtx-greeter
sudo systemctl enable lightdm # do not start until you've installed the required packages
```
## Install packages
```bash
paru -S firefox neofetch exa-git rofi starship neovim kitty
```
## Getting a gui
either reboot or start lightdm
```bash
sudo systemctl enable lightdm
```
should now be in gui

## setup github access
```bash
paru -S openssh
eval $(ssh-agent -s)
ssh-keygen -t ed25519 -C "<email>"
ssh-add ~/.ssh/id_ed25519
```
make sure to copy public key to github

