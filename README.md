
Build the ISO image:
`nix build .#iso`

Flash USB stick:
`sudo dd if=result/iso/*.iso of=/dev/sda status=progres`

Start new PC

Format hard disk, use `gparted`
2 partition:
- biggest labeled "root", fs: ext4
- smallest (~300Mb) labeled "boot", fs: fat32


