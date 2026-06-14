# Place this in /etc/nixos/flake.nix
# Pure NixOS system config — home-manager runs standalone from
# /home/wakizu/home-manager/flake.nix
#
# Usage:
#   sudo nixos-rebuild switch --flake /etc/nixos#nixos
{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Your existing inputs
    helium.url = "gitlab:ntgn/helium-flake";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hypr.nix
      ];
    };
  };
}
