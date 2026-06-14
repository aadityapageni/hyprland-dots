# Place this in /etc/nixos/flake.nix
# It references this repo (hyprland-dots) for user config,
# and manages system-level stuff directly.
#
# Usage:
#   sudo nixos-rebuild switch --flake /etc/nixos#nixos
{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-dots = {
      # Local path for development, or use the GitHub URL for production
      url = "github:aadityapageni/hyprland-dots";
      # url = "path:/home/wakizu/home-manager/dotfiles";  # local override
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland-dots, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix  # your existing NixOS config

        # System-level Hyprland setup
        ({ pkgs, ... }: {
          programs.hyprland = {
            enable = true;
            withUWSM = true;
          };

          # System packages (not user-specific)
          environment.systemPackages = with pkgs; [
            hyprlock hyprpaper hyprsunset
            brightnessctl
            networkmanager
            bluez bluez-tools
            asusctl supergfxctl rog-control-center
            ryzenadj
            foot
          ];

          services.dbus.enable = true;
          hardware.bluetooth.enable = true;
          networking.networkmanager.enable = true;

          nixpkgs.config.allowUnfree = true;
        })

        # Home-manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."wakizu" = {
              imports = [ hyprland-dots.homeManagerModules.default ];
              dotfiles = {
                enable = true;
                theme = "minimal";
                useQuickshell = true;
              };
              home = {
                username = "wakizu";
                homeDirectory = "/home/wakizu";
                stateVersion = "24.11";
              };
            };
          };
        }
      ];
    };
  };
}
