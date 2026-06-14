# Place this in /etc/nixos/flake.nix
# Integrates hyprland-dots (home-manager module) with your existing NixOS config.
#
# Usage:
#   sudo nixos-rebuild switch --flake /etc/nixos#nixos
{
  description = "NixOS + Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Your existing inputs
    helium.url = "gitlab:ntgn/helium-flake";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Home-manager + dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-dots = {
      url = "github:aadityapageni/hyprland-dots";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland-dots, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hypr.nix

        # Home-manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.wakizu = {
              imports = [ hyprland-dots.homeManagerModules.default ];
              dotfiles = {
                enable = true;
                theme = "minimal";
                useQuickshell = true;
              };
              home = {
                username = "wakizu";
                homeDirectory = "/home/wakizu";
                stateVersion = "25.11";
              };
            };
          };
        }
      ];
    };
  };
}
