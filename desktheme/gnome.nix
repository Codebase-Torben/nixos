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
    geary.enable = lib.mkForce false;
    seahorse.enable = lib.mkForce false;
    dconf = {
      enable = true;
      profiles.gdm.databases = [{settings."org/gnome/settings-daemon/plugins/power" = {power-button-action = "suspend";};}];
    };
  };
  environment = {
    systemPackages = {
      with pkgs.gnomeExtensions; [
        #apps-menu
        #places-status-indicator
        system-monitor
        wifi-qrcode
      ];
      excludePackages = pkgs.xterm;
    };
    gnome.excludePackages = (with pkgs; [
      gnome-tour
      #gnome-calendar
      #gnome-terminal
      totem
      geary
      cheese
      gnome-photos
      gedit
      evince
      epiphany
    ]) ++ (with pkgs.gnome; [
      #gnome-music
      gnome-contacts
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
      gnome-keyring.enable = lib.mkForce false;
    };
    udisks2.enable = lib.mkForce true;
    #devmon.enable = lib.mkForce true;
    xserver = {
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
        banner = ''Luna v1.04 ME (NixOS 24.05 gnome Desktop)'';
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
}
