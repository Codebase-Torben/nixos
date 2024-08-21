{
  config,
  pkgs,
  lib,
  ...
}: {
  # Import
  imports = [
    ./shared.nix
  ];

  # Programme
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    hyprlock = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
  };

  # env
  environment = {
    systemPackages = with pkgs; [rofi-wayland];
    variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  # Dineste
  services = {
    dbus = {
      enable = true;
    };
    hypridle = {
      enable = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # Window Manager
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
      };
      extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
    };
  };
}
