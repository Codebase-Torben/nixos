{
  config,
  pkgs,
  lib,
  home-manager,
  modulesPath,
  ...
}: {
  # Imports
  imports = [
    ./alias/global.nix
  ];

  # NixOS
  nix = {
    enable = true;
    package = pkgs.nixFlakes;
    optimise.automatic = true;
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
      restrict-eval = lib.mkForce true;
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
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowBroken = lib.mkDefault false; # normal was true
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
    blacklistedKernelModules = ["ax25" "netrom" "rose" "affs" "bfs" "befs" "freevxfs" "f2fs" "hpfs" "jfs" "minix" "nilfs2" "omfs" "qnx4" "qnx6" "sysv"];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["page_alloc.shuffle=1" "ipv6.disable=1"];
    kernelModules = ["acpi_call" "kvm-intel" "vfat" "exfat" "ext4"];
    readOnlyNixStore = lib.mkForce true;
    initrd = {
      systemd.enable = lib.mkForce false;
      availableKernelModules = [
        "ahci"
        "dm_mod"
        "sd_mod"
        "uas"
        "usb_storage"
        "xhci_pci"
      ];
    };
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
      "net.core.bpf_jit_enable" = lib.mkForce false;
      "net.ipv4.conf.all.log_martians" = lib.mkForce true;
      "net.ipv4.conf.all.rp_filter" = lib.mkForce "1";
      "net.ipv4.conf.default.log_martians" = lib.mkForce true;
      "net.ipv4.conf.default.rp_filter" = lib.mkForce "1";
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
    stateVersion = "24.05"; # NixOS install Version
    switch.enable = true;
    autoUpgrade = {
      enable = false;
      allowReboot = true;
      dates = "daily";
      flags = ["--update-input" "nixpkgs" "--update-input" "nixpkgs-Release" "--update-input" "home-manager" "--commit-lock-file"];
      operation = "switch"; # switch or boot
      persistent = true;
      randomizedDelaySec = "15min";
      rebootWindow = {
        lower = "02:00";
        upper = "04:00";
      };
    };
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
    #font = "";
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
    cpu = {
      intel = {
        updateMicrocode = lib.mkForce true;
        sgx.provision.enable = lib.mkForce false;
      };
    };
    enableRedistributableFirmware = lib.mkForce true;
  };

  # Sicherheit
  security = {
    auditd.enable = true;
    audit = {
      enable = lib.mkForce true;
      backlogLimit = 512;
      failureMode = "panic";
      rules = ["-a exit,always -F arch=b64 -S execve"];
    };
    allowSimultaneousMultithreading = true;
    lockKernelModules = lib.mkForce true;
    protectKernelImage = lib.mkForce true;
    apparmor = {
      enable = lib.mkForce true;
      killUnconfinedConfinables = lib.mkForce true;
    };
    dhparams = {
      enable = true;
      stateful = false;
      defaultBitSize = "3072";
    };
    doas = {
      enable = false;
      wheelNeedsPassword = lib.mkForce true;
    };
    sudo = {
      enable = false;
      execWheelOnly = lib.mkForce true;
      wheelNeedsPassword = lib.mkForce true;
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
      allowedTCPPorts = [80 443];
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

  # General Programme
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
      };
    };
    git = {
      enable = true;
      prompt.enable = true;
      config = {
        branch.sort = "-committerdate";
        commit.gpgsign = true;
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        gpg.format = "ssh";
        user = {
          email = "nix@nixos.local";
          name = "NIXOS, Generic Local";
          signingkey = "~/.ssh/id_ed25519.pub";
        };
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

  # Schriftarten
  fonts = {
    packages = with pkgs; [(nerdfonts.override {fonts = ["FiraCode"];})];
  };

  # Dienste
  services = {
    #power-profiles-daemon.enable = true;
    thermald.enable = true;
    logind.hibernateKey = "ignore";
    opensnitch = {
      enable = false;
      settings = {
        firewall = "nftables";
        defaultAction = "deny";
      };
    };
    fstrim = {
      enable = true;
      #interval = "monthly";
    };
  };
}
