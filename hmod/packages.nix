{ config, lib, pkgs, ... }: with lib; let cfg = config.dotfiles; in mkIf cfg.enable {
  home.packages = with pkgs; [
    # WM & Shell
    hyprland
    hyprlock
    hyprpaper
    hyprsunset

    # Quickshell
    quickshell

    # Terminal
    foot

    # App launchers
    tofi

    # System utilities
    brightnessctl
    playerctl
    wireplumber
    networkmanager
    bluez
    bluez-tools
    cliphist
    wl-clipboard
    grim
    slurp
    socat
    jq
    pavucontrol

    # ASUS specific (override with allowUnfree)
    asusctl
    supergfxctl
    rog-control-center

    # Screenshot / media
    libnotify
    obsidian
    yazi

    # Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono

    # System monitor / dev
    btop
    fastfetch
    neovim
  ] ++ lib.optionals pkgs.stdenv.isx86_64 [ ryzenadj ];
}
