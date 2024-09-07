{
  config,
  pkgs,
  lib,
  ...
}: {
  # Programme
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        librewolf = {
          profile = "${lib.getBin pkgs.firejail}/etc/firejail/librewolf.profile";
          executable = "${lib.getBin pkgs.librewolf}/bin/librewolf";
        };
      };
    };
  };

  # env
  environment = {
    systemPackages = with pkgs; [alacritty kittysay];
    variables = {
      BROWSER = "librewolf";
      TERMINAL = "alacritty";
      MUSIC = "gnome-music";
      EMAIL = "geary";
    };
  };

  # Dienste
  services = {
    autosuspend.enable = lib.mkForce false;
    blueman.enable = true;
    printing.enable = lib.mkForce true;
    xserver = {
      enable = true;
      autoRepeatDelay = 150;
      autoRepeatInterval = 15;
      xkb.layout = "de";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  # Hardware
  hardware = {
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-media-driver];
    pulseaudio.enable = false; # disable pulseaudio here (use pipewire)
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  # Sicherheit
  security.rtkit.enable = true; # realtime, needed for audio
}
