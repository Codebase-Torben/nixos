{
  config,
  pkgs,
  lib,
  ...
}: {
  # Drucken aus Programmen
  programs = {
    system-config-printer.enable = lib.mkForce true;
  };

  # Office Software
  environment = {
    systemPackages = with pkgs; [
      #betterbird
      libreoffice-qt6-fresh
    ];
  };

  # Dienste
  services = {
    printing = {
      enable = lib.mkDefault true;
      stateless = true;
      startWhenNeeded = true;
      cups-pdf = {
        enable = true;
      };
    };
  };
}
