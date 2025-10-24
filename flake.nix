{
  description = "Lunaflake";
  inputs = {
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
          ./users/resources/torben/git.nix
          #./modules/openweb-ui.nix
          ./modules/docker.nix # little fun dockers Speedtest, Yopass, Chef
          #./modules/virtual.nix
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
