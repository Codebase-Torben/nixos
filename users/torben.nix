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
        audacity
        #bandwhich #Cli network utilization tool
        #bitwarden-desktop
        bmon
        dnsutils
        dig
        fd
        #hyperfine #Cli Benchmark
        kittysay
        kmon
        krita
        moreutils
        nix-tree
        nix-search-cli
        nix-output-monitor
        openssl
        portal #Datatransport tool
        rustscan #rust based nmap
        shellcheck
        sysz
        tailspin
        termshark
        tldr #man based code examples :D
        tree
        tz #Timezone tool
        #ugm #Cli Usermanagement
        vulnix
        vlc
        vscodium
        #xh #Tool for sending HTTP requests
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
            history = 50000;
          };
          font.size = 12;
          cursor.style = {
            shape = "Underline";
            blinking = "On";
          };
          colors.primary = {
            background = "#2b2d2f";
            foreground = "#ebeff3";
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
            startup_mode = "Fullscreen";
            #opacity = 0.8;
          };
        };
      };
      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
      };
      bat = {
      enable = true;
      #extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch prettybat];
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
        #icons = "auto";
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
            #app-menu.extensionUuid
            #places-status-menu.extensionUuid
            system-monitor.extensionUuid
            todotxt.extensionUuid
            #toggle-alacritty.extensionUuid
            wireguard-vpn-extension.extensionUuid
            wireless-hid.extensionUuid
            wifi-qrcode.extensionUuid
          ];
          # Dock Favoriten
          favorite-apps = ["org.gnome.Nautilus.desktop" "librewolf.desktop" "Alacritty.desktop" "org.gnome.Console.desktop" "codium.desktop" "org.gnome.Calendar.desktop" "nixos-manual.desktop" "org.gnome.Weather.desktop"];
        };
        # Keybindings (MacBook)
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Alacritty Terminal";
          command = "alacritty";
          binding = "<Super>Return";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Editor";
          command = "gnome-text-editor";
          binding = "LaunchA";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name = "Dateimanager";
          command = "nautilus";
          binding = "LaunchB";
        };
        # Wochentag anzeigen
        "org/gnome/desktop/interface" = {
          clock-show-weekday = true;
        };
        # Hintergrundbild definieren (muss vorhanden sein oder git)
        "org/gnome/desktop/background" = {
          picture-uri = "Bilder/Luna_day.png";
          picture-uri-dark = "Bilder/Luna_night.png";
        };
      };
    };
  };
}
