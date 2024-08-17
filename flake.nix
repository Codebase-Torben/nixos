{
  description = "nixos generic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-Release.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-Release = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-Release";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-Release,
    home-manager,
    home-manager-Release,
  }: {
    nixosConfigurations = {
      # NixOS
      nixbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/macbook.nix
				./modules/office.nix
          ./modules/timeserver.nix
				./desktheme/shared.nix
          ./desktheme/gnome.nix
          ./user/flake.nix
          {networking.hostName = "nixbook";}
        ];
      };
    };
  };
}