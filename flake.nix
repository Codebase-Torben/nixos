{
  description = "nixos generic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-Release.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    disko,
    nixpkgs,
    nixpkgs-Release,
    home-manager,
    home-manager-Release,
  }: {
    nixosConfigurations = {
      #################
      # GENERIC NIXOS #
      #################
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/nvidia-off.nix
          ./modules/chronyPublic.nix
          ./desktop/gnome.nix
          ./user/desktop/me.nix
          ./server/adguard.nix
          ./server/virtual.nix
          {networking.hostName = "nixos";}
        ];
      };
