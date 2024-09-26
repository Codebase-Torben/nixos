# NixOS Luna v 1.07 Home Edition Alpha 22.09.2024
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
    systemPackages = with pkgs.gnomeExtensions; [
      #apps-menu
      #places-status-indicator
      system-monitor
      wifi-qrcode
    ];
    gnome.excludePackages =
      (with pkgs; [
        gnome-tour
        #gnome-calendar
        #gnome-terminal
        totem
        #geary
        cheese
        gnome-photos
        gedit
        evince
        epiphany
      ])
      ++ (with pkgs.gnome; [
        #gnome-music
        #gnome-contacts
        #gnome-characters
        tali
        iagno
        hitori
        atomix
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
        banner = ''Luna v1.07 Home Edition (NixOS 24.05 gnome Desktop)'';
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
}
