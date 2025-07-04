# NixOS Luna v.1.0.8 Git Edition 03.06.2025
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

  # Gnome Programme
  programs = {
    geary.enable = lib.mkForce true;
    seahorse.enable = lib.mkForce false;
    dconf = {
      enable = true;
      profiles.gdm.databases = [{settings."org/gnome/settings-daemon/plugins/power" = {power-button-action = "suspend";};}];
    };
  };

  # Env
  environment = {
    systemPackages = with pkgs.gnomeExtensions; [
      burn-my-windows
      dejaview
      desktop-icons-ng-ding
      quake-terminal
      runcat
      system-monitor
      transparent-top-bar-adjustable-transparency
      wifi-qrcode
      #applications-menu
      #battery-health-charging needs kernelModule applesmc-next on intel macbook
      #places-status-indicator
      #wireguard-vpn-extension
      #wireless-hid
    ];
    gnome.excludePackages = with pkgs; [
      gnome-tour
      totem
      cheese
      gnome-photos
      gedit
      evince
      epiphany
    ];
  };

  # Dienste
  services = {
    gvfs.enable = lib.mkForce true;
    gnome = {
      core-apps.enable = lib.mkForce true;
      games.enable = lib.mkForce false;
      gnome-browser-connector.enable = lib.mkForce false;
      gnome-initial-setup.enable = lib.mkForce false;
      gnome-online-accounts.enable = lib.mkForce true;
      gnome-remote-desktop.enable = lib.mkForce false;
      gnome-user-share.enable = lib.mkForce true;
      gnome-keyring.enable = lib.mkForce true;
    };
    #udisks2.enable = lib.mkForce true;
    #devmon.enable = lib.mkForce true;
    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = true;
        banner = ''Luna v.1.0.8 Git Edition (NixOS 25.05)'';
      };
    };
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
  };
}
