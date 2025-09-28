{
  config,
  pkgs,
  lib,
  ...
}: {
  # Imports
  imports = [
    ./alias/global.nix
  ];

  # NixOS
  nix = {
    enable = true;
    daemonCPUSchedPolicy = "idle";
    gc = {
      automatic = true;
      dates = "daily";
      persistent = true;
      options = "--delete-older-than 366d";
    };
    optimise = {
      automatic = true;
      dates = ["daily"];
    };
    extraOptions = ''
      builders-use-substitutes = false
      experimental-features = nix-command flakes'';
    settings = {
      auto-optimise-store = true;
      allowed-users = lib.mkForce ["@wheel"];
      trusted-users = lib.mkForce ["@wheel"];
      flake-registry = "";
      http2 = lib.mkForce false;
      sandbox = lib.mkForce true;
      sandbox-build-dir = "/build";
      sandbox-fallback = lib.mkForce false;
      trace-verbose = true;
      restrict-eval = lib.mkForce false;
      require-sigs = lib.mkForce true;
      preallocate-contents = true;
      allowed-uris = [
        "https://nixpkgs-unfree.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      substituters = [
        "https://nixpkgs-unfree.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  # NIXPKGS
  nixpkgs = {
    #hostPlatform = lib.mkDefault "aarch64-linux"; Apple Silicon
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowBroken = lib.mkDefault true;
      allowUnfree = lib.mkDefault true;
    };
  };

  # Dateisysteme
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-diskseq/1-part2";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-diskseq/1-part1";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  # Boot
  boot = {
    initrd = {
      systemd.enable = lib.mkForce false;
      availableKernelModules = ["aesni_intel" "ahci" "applespi" "applesmc" "dm_mod" "cryptd" "intel_lpss_pci" "nvme" "thunderbolt" "sd_mod" "uas" "usbhid" "usb_storage" "xhci_pci"];
    };
    blacklistedKernelModules = ["affs" "b43" "befs" "bfs" "brcmsmac" "bcma" "freevxfs" "hpfs" "jfs" "minix" "nilfs2" "omfs" "qnx4" "qnx6" "k10temp" "ssb" "wl"]; # old MacBookPro14,1 "brcmfmac"
    extraModulePackages = [config.boot.kernelPackages.zenpower];
    kernelPackages = (
      if (config.system.nixos.release == "24.11") # update on 25.11 to 25.05
      then pkgs.linuxPackages
      else pkgs.linuxPackages_latest
    );
    kernelParams = ["amd_pstate=active" "copytoram" "page_alloc.shuffle=1"];
    kernelModules = ["amd-pstate" "amdgpu" "exfat" "kvm-amd" "kvm-intel" "uas" "vfat"];
    #readOnlyNixStore = lib.mkForce true;
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
      tmpfsSize = "85%";
    };
    loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 4;
      };
    };
    kernel.sysctl = {
      "kernel.kptr_restrict" = lib.mkForce 2;
      "kernel.ftrace_enabled" = lib.mkForce false;
      "net.ipv4.icmp_echo_ignore_broadcasts" = lib.mkForce true;
      "net.ipv4.conf.all.accept_redirects" = lib.mkForce false;
      "net.ipv4.conf.all.secure_redirects" = lib.mkForce false;
      "net.ipv4.conf.default.accept_redirects" = lib.mkForce false;
      "net.ipv4.conf.default.secure_redirects" = lib.mkForce false;
      "net.ipv6.conf.all.accept_redirects" = lib.mkForce false;
    };
  };

  # System
  system = {
    stateVersion = "25.05"; # NixOS install Version
    switch.enable = true;
    rebuild.enableNg = true;
    includeBuildDependencies = false;
    #autoUpgrade = {
    #enable = false;
    #allowReboot = true;
    #dates = "daily";
    #flags = ["--update-input" "nixpkgs" "--update-input" "nixpkgs-Release" "--update-input" "home-manager" "--commit-lock-file"];
    #operation = "switch"; # switch or boot
    #persistent = true;
    #randomizedDelaySec = "15min";
    #rebootWindow = {
    #lower = "02:00";
    #upper = "04:00";
    #};
    #};
  };
  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = false;
  };
  powerManagement = {
    enable = true;
    powertop.enable = false;
    cpuFreqGovernor = "powersave";
  };
  console = {
    earlySetup = lib.mkForce true;
    keyMap = "de";
  };
  swapDevices = [];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # systemd
  systemd = {
    targets = {
      sleep.enable = true;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  # Hardware
  hardware = {
    acpilight.enable = true;
    amdgpu = {
      amdvlk.enable = true;
      opencl.enable = false;
    };
    enableAllFirmware = lib.mkForce true;
    enableAllHardware = lib.mkForce true;
    enableRedistributableFirmware = lib.mkForce true;
    cpu = {
      amd = {
        updateMicrocode = true;
        ryzen-smu.enable = true;
        sev.enable = lib.mkForce false;
      };
      intel = {
        updateMicrocode = true;
        sgx.provision.enable = lib.mkForce false;
      };
    };
    i2c.enable = true;
    intel-gpu-tools.enable = true;
    uinput.enable = true;
    graphics = {
      enable = lib.mkForce true;
      enable32Bit = lib.mkForce false;
      extraPackages = with pkgs; [intel-media-driver vpl-gpu-rt]; # intel-compute-runtime
    };
  };

  # Sicherheit
  security = {
    # lockKernelModules = lib.mkForce true;
    auditd.enable = false;
    allowSimultaneousMultithreading = true;
    protectKernelImage = lib.mkForce true;
    audit = {
      enable = lib.mkForce false;
      backlogLimit = 512;
      failureMode = "panic";
      rules = ["-a exit,always -F arch=b64 -S execve"];
    };
    apparmor = {
      enable = lib.mkForce true;
      killUnconfinedConfinables = lib.mkForce true;
    };
    dhparams = {
      enable = true;
      stateful = false;
      defaultBitSize = "3072";
    };
    sudo-rs = {
      enable = true;
      execWheelOnly = lib.mkForce true;
      wheelNeedsPassword = lib.mkForce true;
    };
  };

  # Netzwerk
  networking = {
    domain = "pinasse.home";
    useDHCP = lib.mkDefault true;
    enableIPv6 = lib.mkForce false;
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      checkReversePath = true;
    };
  };

  # root
  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = null; # disable root account
        openssh.authorizedKeys.keys = ["ssh-ed25519 AAA-#locked#-"];
      };
    };
  };

  # home-manager
  home-manager = {
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # Globale Software
  programs = {
    gnupg.agent.enable = true;
    nano.enable = true;
    htop.enable = true;
    iftop.enable = true;
    iotop.enable = true;
    usbtop.enable = true;
    zsh.enable = true;
    ssh = {
      hostKeyAlgorithms = ["ssh-ed25519"];
      pubkeyAcceptedKeyTypes = ["ssh-ed25519"];
      ciphers = ["chacha20-poly1305@openssh.com"];
      kexAlgorithms = ["curve25519-sha256" "curve25519-sha256@libssh.org"];
      knownHosts = {
        github = {
          extraHostNames = ["github.com" "api.github.com" "git.github.com"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
        gitlab = {
          extraHostNames = ["gitlab.com" "api.gitlab.com" "git.gitlab.com"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
        };
        codeberg = {
          extraHostNames = ["codeberg.org" "api.codeberg.org" "git.codeberg.org"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVIC02vnjFyL+I4RHfvIGNtOgJMe769VTF1VR4EB3ZB";
        };
        sourcehut = {
          extraHostNames = ["sr.ht" "api.sr.ht" "git.sr.ht"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
        };
      };
    };
    git = {
      enable = true;
      prompt.enable = true;
      config = {
        http = {
          sslVerify = "true";
          sslVersion = "tlsv1.3";
          version = "HTTP/1.1";
        };
        protocol = {
          allow = "never";
          file.allow = "always";
          git.allow = "never";
          ssh.allow = "always";
          http.allow = "never";
          https.allow = "always";
        };
      };
    };
  };

  # env
  environment = {
    interactiveShellInit = ''uname -a'';
    variables = {
      VISUAL = "nano";
      EDITOR = "nano";
    };
    systemPackages = with pkgs; [alejandra];
    shells = [pkgs.bashInteractive pkgs.zsh];
  };

  # Sprache
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # Schriftart
  fonts = {
    packages = [pkgs.nerd-fonts.hack]; #pkgs.nerd-fonts.FiraCode or pkgs.nerd-fonts.GeistMono for other fonts
  };

  # Dienste
  services = {
    fwupd.enable = true;
    smartd.enable = true;
    openssh.enable = false;
    power-profiles-daemon.enable = lib.mkForce false;
    logind.hibernateKey = "ignore";
    fstrim = {
      enable = true;
      interval = "daily";
    };
    tlp = {
      enable = true;
      settings = {
        USB_AUTOSUSPEND = "0"; # disable
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        RADEON_DPM_PERF_LEVEL_ON_AC = "low";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        RADEON_DPM_STATE_ON_AC = "battery";
        RADEON_DPM_STATE_ON_BAT = "battery";
        RADEON_POWER_PROFILE_ON_AC = "low";
        RADEON_POWER_PROFILE_ON_BAT = "low";
        PLATFORM_PROFILE_ON_AC = "low-power";
        PLATFORM_PROFILE_ON_BAT = "low-power";
      };
    };
    usbguard = {
      enable = false;
      rules = ''
        allow with-interface one-of { 02:*:* 08:*:* 09:*:* 11:*:* }
        reject with-interface all-of { 08:*:* 03:00:* }
        reject with-interface all-of { 08:*:* 03:01:* }
        reject with-interface all-of { 08:*:* e0:*:* }
        reject with-interface all-of { 08:*:* 02:*:* }
        allow with-interface one-of { 03:00:01 03:01:01 } if !allowed-matches(with-interface one-of { 03:00:01 03:01:01 })
      '';
    };
  };
}
