{
  description = "nixos generic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations = {
      # NixOS
      nixbook = nixpkgs.lib.nixosSystem {
        #system = "aarch64-linux"; Apple Silicon
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./configuration.nix
          ./hardware/macbook.nix
          ./desktheme/gnome.nix
          ./users/torben.nix
          #./modules/office.nix
          ./modules/docker.nix
          ./modules/virtual.nix
          ./modules/timeserver.nix
          {
            networking = {
              hostName = "nixbook";
            };
          }
        ];
      };
    };
  };
}
