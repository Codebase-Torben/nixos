{
  config,
  pkgs,
  lib,
  ...
}: {
  boot = {
    initrd = {
      luks = {
        fido2Support = false;
        gpgSupport = false;
        mitigateDMAAttacks = true;
        yubikeySupport = false;
      };
    };
  };

  # Sicherheit
  security = {
    pam = {
      services = {
        login.yubicoAuth = true;
        sudo.yubicoAuth = true;
      };
      yubico = {
        enable = false;
        challengeResponePath = "$HOME/.yubico/challenge";
        control = "optional"; # required or optional
        debug = true;
        mode = "challenge-response";
      };
    };
  };

  # Verwendete Software

  # pam_u2f
  # libu2f-host
  # yubico-pam

  environment = {
    systemPackages = with pkgs; [
      age-plugin-yubikey
      yubioath-flutter
      yubikey-touch-detector
      yubikey-manager
      yubikey-manager-qt
      yubikey-personalization
      yubikey-personalization-gui
    ];
  };

  # Dienste
  services = {
    pcscd.enable = true;
    udev.extraRules = ''    
      ACTION=="remove",\
      ENV{ID_BUS}=="usb",\
      ENV{ID_MODEL_ID}=="0407",\
      ENV{ID_VENDOR_ID}=="1050",\
      ENV{ID_VENDOR}=="Yubico",\
      RUN+="${pkgs.systemd}/bin/loginctl lock-sessions" '';
  };

  # Programme
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
