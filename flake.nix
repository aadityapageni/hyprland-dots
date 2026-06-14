{
  description = "Home-manager dotfiles for Hyprland + Quickshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeManagerModules.default = import ./hmod;
    homeManagerModules.dotfiles = import ./hmod;

    homeConfigurations = let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      example = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          self.homeManagerModules.default
          {
            home = {
              username = "wakizu";
              homeDirectory = "/home/wakizu";
              stateVersion = "24.11";
            };
          }
        ];
      };
    };
  };
}
