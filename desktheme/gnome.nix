# NixOS Luna v.1.0.7 Home Edition Alpha 19.12.2024
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
      applications-menu
      #battery-health-charging needs kernelModule applesmc-next on intel macbook
      burn-my-windows
      dejaview
      places-status-indicator
      quake-terminal
      runcat
      system-monitor
      transparent-top-bar-adjustable-transparency
      #wireguard-vpn-extension
      #wireless-hid
      wifi-qrcode
    ];
    gnome.excludePackages = (with pkgs; [
      gnome-tour
      totem
      cheese
      gnome-photos
      gedit
      evince
      epiphany
    ]);
  };

  # Dienste
  services = {
    gvfs.enable = lib.mkForce true;
    gnome = {
      core-utilities.enable = lib.mkForce true;
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
    xserver = {
      displayManager.gdm = {
        enable = true;
        autoSuspend = true;
        banner = ''Luna v.1.0.7 Home Edition (NixOS 24.11)'';
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
}