# joshprk's nixos

This system configuration is a result of months of learning and trying with many
well though-out design choices along the way. It is designed for a single-user
desktop computer. It has the following features:

- Home Manager
- Secrets managed with Agenix
- Impermanence through in-ram root directory
- BTRFS with zstd compression
- LUKS encryption with automatic TPM unlock
- Compressed zram swapfile
- Secure boot support using Lanzaboote
- XDG-compliant home directory
- Neovim through Nixvim configuration
- Hyprland configuration with Vim motions
- Cached, automatic development shells using nix-direnv
- Flatpak-based support for gaming software
- Remote access using Tailscale, SSH, and Moonlight streaming
- Declared nmcli networking through Nix options
- Astal-based desktop shell
- Completely pure and stateless

If you have any questions, feel free to contact me at joshprk on Discord.
