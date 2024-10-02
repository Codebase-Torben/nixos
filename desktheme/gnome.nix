# NixOS Luna v.1.0.7 Home Edition Alpha 28.09.2024
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
  environment = {
    systemPackages = with pkgs.gnomeExtensions; [battery-health-charging wifi-qrcode];
    gnome.excludePackages = with pkgs; [
      #gnome-characters
      gnome-calendar
      gnome-contacts
      gnome-photos
      gnome-tour
      #gnome-terminal
      #gnome-music
      atomix
      cheese
      geary
      epiphany
      iagno
      totem
      gedit
      evince
      hitori
      tali
    ];
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
      gnome-online-miners.enable = lib.mkForce false;
      gnome-remote-desktop.enable = lib.mkForce false;
      gnome-user-share.enable = lib.mkForce true;
      gnome-keyring.enable = lib.mkForce true;
    };
    udisks2.enable = lib.mkForce true;
    devmon.enable = lib.mkForce true;
    xserver = {
      displayManager.gdm = {
        enable = true;
        autoSuspend = true;
        banner = ''Luna v.1.0.7 Home Edition (NixOS 24.05)'';
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
}
