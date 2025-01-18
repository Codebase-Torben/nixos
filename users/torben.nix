{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: {
  # Benutzer
  users.users.torben = {
    initialHashedPassword = "$y$j9T$SSQCI4meuJbX7vzu5H.dR.$VUUZgJ4mVuYpTu3EwsiIRXAibv2ily5gQJNAHgZ9SG7"; # start
    description = "Torben";
    uid = 1013;
    group = "users";
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager" "audio" "storage" "input" "video" "docker" "libvirtd" "qemu-libvirtd"];
  };
  # home-manager
  home-manager.users.torben = {
    home = {
      stateVersion = "24.11";
      enableNixpkgsReleaseCheck = false;
      username = "torben";
      homeDirectory = "/home/torben";
      keyboard.layout = "de";
      sessionVariables = {
        EDITOR = "nano";
        VISUAL = "nano";
        SHELLCHECK_OPTS = "-e SC2086";
      };
      file = {
        ".config/starship.toml".source = ./resources/starship/colorconf.toml;
        "Bilder/Luna_day.png".source = ./resources/torben/luna_hell.png;
        "Bilder/Luna_night.png".source = ./resources/torben/luna_dunkel.png;
      };
      packages = with pkgs; [
        asn
        age
        bandwhich
        bmon
        binsider
        certgraph
        caligula
        curlie
        compose2nix
        cifs-utils
        ddgr
        docker
        docker-compose
        dust
        dmidecode
        dnstracer
        dnsutils
        fastfetch
        ffsend
        filezilla
        goaccess
        gobang
        gopass
        git-crypt
        git-agecrypt
        gping
        graphviz
        httpie
        hyperfine
        inetutils
        shellcheck
        shfmt
        s-tui
        stress
        socialscan
        sysz
        tea
        tcping-go
        tldr
        tlsinfo
        termdbms
        termshark
        tshark
        tig
        tree
        trippy
        tz
        openssl
        progress
        pv
        kmon
        keepassxc
        keepassxc-go
        moreutils
        nodejs
        netscanner
        ncftp
        nix-du
        nix-tree
        nix-top
        nix-init
        nix-search-cli
        nix-output-monitor
        nixpkgs-review
        nix-prefetch-scripts
        nixfmt-rfc-style
        nixpkgs-fmt
        nvme-cli
        nodejs
        fastfetch
        fd
        jq
        oha
        openssl
        paper-age
        passage
        podman
        podman-compose
        podman-tui
        pciutils
        portal
        pwgen
        rage
        rsync
        ssh-audit
        undervolt
        usbutils
        ugm
        webanalyze
        vulnix
        xh
        yamlfmt
        yarn
        yubikey-manager
        yq
        zgrviewer
        #home
        audacity
        #bitwarden-desktop
        dig
        kittysay
        krita
        ventoy-full
        vlc
        vscodium
      ];
    };
    fonts.fontconfig.enable = true;
    programs = {
      btop.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      #thefuck.enable = true;
      starship.enable = true;
      gh-dash.enable = true;
      git.enable = true;
      gitui.enable = true;
      #lazygit.enable = true;
      home-manager.enable = true;
      librewolf.enable = true;
      alacritty = {
        enable = true;
        settings = {
          selection = {
            save_to_clipboard = true;
          };
          scrolling = {
            history = 90000;
          };
          font.size = 12;
          cursor.style = {
            shape = "Underline";
            blinking = "On";
          };
          colors.primary = {
            background = "#222222";
            foreground = "#eeeeee";
          };
          colors.normal = {
            black = "#2e2e2e";
            red = "#eb4129";
            green = "#abe047";
            yellow = "#f6c744";
            blue = "#47a0f3";
            magenta = "#7b5cb0";
            cyan = "#64dbed";
            white = "#e5e9f0";
          };
          colors.bright = {
            black = "#565656";
            red = "#ec5357";
            green = "#c0e17d";
            yellow = "#f9da6a";
            blue = "#49a4f8";
            magenta = "#a47de9";
            cyan = "#99faf2";
            white = "#ffffff";
          };
          window = {
            decorations = "none";
            #startup_mode = "Fullscreen";
            opacity = 0.9;
          };
        };
      };
      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
      };
      bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batman batgrep batwatch];
      };
      git = {
        userName = lib.mkForce "Git Signing";
        userEmail = lib.mkForce "torben@nixbook";
        signing = {
          signByDefault = lib.mkForce false;
          key = lib.mkForce "~/.ssh/schluessel4git.pub";
        };
        extraConfig = {
          protocol = {
            allow = "never";
            file.allow = "always";
            git.allow = "never";
            ssh.allow = "always";
            http.allow = "never";
            https.allow = "never";
          };
        };
      };
      eza = {
        enable = true;
        git = true;
        icons = "auto";
        extraOptions = ["--group-directories-first" "--header"];
      };
      fd = {
        enable = true;
        extraOptions = ["--absolute-path" "--no-ignore"];
      };
      gh = {
        enable = true;
        settings.git_protocol = "ssh";
      };
      zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;
        history = {
          extended = true;
          ignoreSpace = true;
          share = true;
        };
      };
    };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            burn-my-windows.extensionUuid
            dejaview.extensionUuid
            quake-terminal.extensionUuid
            runcat.extensionUuid
            system-monitor.extensionUuid
            transparent-top-bar-adjustable-transparency.extensionUuid
            wifi-qrcode.extensionUuid
            #applications-menu.extensionUuid
            #places-status-indicator.extensionUuid
            #wireguard-vpn-extension.extensionUuid
            #wireless-hid.extensionUuid
          ];
          disabled-extensions = [
            "apps-menu@gnome-shell-extensions.gcampax.github.com"
            "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "places-menu@gnome-shell-extensions.gcampax.github.com"
            "status-icons@gnome-shell-extensions.gcampax.github.com"
            "window-list@gnome-shell-extensions.gcampax.github.com"
            "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            #"light-style@gnome-shell-extensions.gcampax.github.com"
          ];
          # Dock Favoriten
          favorite-apps = ["org.gnome.Nautilus.desktop" "librewolf.desktop" "org.gnome.Console.desktop" "virt-manager.desktop" "codium.desktop" "org.gnome.Calendar.desktop" "nixos-manual.desktop" "org.gnome.Weather.desktop"];
        };
        # Runcat
        "org/gnome/shell/extensions/runcat" = {
          displaying-items = "character-and-percentage";
          idle-threshold = 11;
        };
        # System-Monitor
        "org/gnome/shell/extensions/system-monitor" = {
          show-cpu = false;
          show-memory = false;
          show-swap = false;
          show-upload = true;
          show-download = true;
        };
        # Quake Terminal
        "org/gnome/shell/extensions/quake-terminal" = {
          terminal-id = "Alacritty.desktop";
          auto-hide-window = true;
          render-on-current-monitor = true;
          animation-time = 180;
          horizontal-size = 100;
          vertical-size = 90;
          terminal-shortcut = ["less"]; #disired key
        };
        # DejaView
        "org/gnome/shell/extensions/dejaview" = {
          auto-start = false;
          message-text = "Es ist Zeit für eine Miause-Pause!";
          interval-min = 61;
          timer-enabled = false;
        };
        # Nachtmodus  
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-schedule-from = 20.0;
          night-light-schedule-to = 6.0;
          night-light-temperature = "uint32 4250";
        };
        # Keybindings (MacBook)
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Editor";
          command = "gnome-text-editor";
          binding = "LaunchA";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Dateimanager";
          command = "nautilus";
          binding = "LaunchB";
        };
        # Gnome Konsole
        "org/gnome/Console" = {
          audible-bell = false;
          custom-font = "FiraCode Nerd Font 11";
          ignore-scrollback-limit = true;
          use-system-font = false;
          visual-bell = false;
          #last-window-maximised = false;
          #scrollback-lines = "int64 1000x";
        };
        # Optische Anpassungen
        "org/gnome/desktop/background" = {
          # Hintergrundbild definieren (muss vorhanden sein oder git)
          picture-uri = "Bilder/Luna_day.png";
          picture-uri-dark = "Bilder/Luna_night.png";
        };
        "org/gnome/desktop/interface" = {
          # Hell oder Dunkel?
          color-scheme = "default"; #oder "prefer-dark";          
          # Hauptfarbe Gnome
          accent-color = "teal";
          # Funktionsecken oben links
          enable-hot-corners = false;
          # Wochentag anzeigen
          clock-show-weekday = true;
        };
        "org/gnome/mutter" = {
          # Dynamische Anzahl von Arbeitfl.
          dynamic-workspaces = true;
          # Arbeitsfl. nur auf Hauptbildschirm
          workspaces-only-on-primary = true;
        };
      };
    };
  };
}
