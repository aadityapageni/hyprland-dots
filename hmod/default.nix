{ config, lib, pkgs, ... }: {
  options.dotfiles = {
    enable = lib.mkEnableOption "dotfiles suite (Hyprland + Quickshell + scripts)";
    username = lib.mkOption {
      type = lib.types.str;
      default = config.home.username;
    };
    homeDir = lib.mkOption {
      type = lib.types.str;
      default = config.home.homeDirectory;
    };
    theme = lib.mkOption {
      type = lib.types.str;
      default = "minimal";
      description = "Active theme name";
    };
    enableLuaConfig = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use Lua-based Hyprland config (vs static .conf)";
    };
    useQuickshell = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use Quickshell panel instead of Waybar";
    };
  };

  imports = [
    ./packages.nix
    ./hyprland.nix
    ./quickshell.nix
    ./scripts.nix
    ./themes.nix
    ./misc.nix
  ];
}
