# Konfiguration des Userhome mit home-manger 
{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: {
# users
users.users.torben = {
  initialHashedPassword = "$y$j9T$SSQCI4meuJbX7vzu5H.dR.$VUUZgJ4mVuYpTu3EwsiIRXAibv2ily5gQJNAHgZ9SG7"; # start
  description = "Torben";
  uid = 40100;
  group = "users";
  createHome = true;
  isNormalUser = true;
  shell = pkgs.zsh;
  extraGroups = ["wheel" "networkmanager" "audio" "storage" "input" "video" "docker" "libvirtd" "qemu-libvirtd"];
  #openssh.authorizedKeys.keys = ["ssh-ed25519 AAA-#locked#-"];
};
# home-manager
home-manager.users.torben = {
  home = {
    stateVersion = "24.05";
    username = "torben";
    homeDirectory = "/home/torben";
    keyboard.layout = "de";
      sessionVariables = {
        EDITOR = "nano";
        VISUAL = "nano";
        #PAGER = "bat";
        SHELLCHECK_OPTS = "-e SC2086";
      };
      file = {".config/starship.toml".source = ./resources/starship/colorconf.toml;};
      packages = with pkgs; [
        audacity
        #asn
        #age #file encryption
        #bandwhich #Cli network utilization tool
        bmon
        dnsutils
        dig
        #git-crypt
        #git-agecrypt
        #httpie
        #hyperfine #Cli Benchmark
        openssl
        tldr #man based code examples :D
        shellcheck
        sysz
        tailspin
        kmon
        krita
        kittysay
        moreutils
        fd
        #oha #Webserver tests
        remmina
        tree
        #trippy
        termshark
        tz #Timezone tool
        portal #Data transport
        rustscan #rust based nmap
        ugm #Cli Usermanagement
        #viddy
        vulnix
        vlc
        vscode
        xh #Tool for sending HTTP requests
        ];
      };
    fonts.fontconfig.enable = true;
    programs = {
      btop.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      thefuck.enable = true;
      starship.enable = true;
      gh-dash.enable = true;
      git.enable = true;
      gitui.enable = true;
      lazygit.enable = true;
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
        mouse = {
          hide_when_typing = true;
          };
        font.size = 12;
        colors.primary = {
          background = "#000000";
          foreground = "#fffbf6";
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
          };
        };
      };
    atuin = {
      enable = true;
      #flags = ["--disable-up-arrow"];
      };
    #bat = { #broken since 20082024
      #enable = true;
      #extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch prettybat];
      #};
    eza = {
      enable = true;
      #git = true;
      icons = true;
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
      #defaultKeymap = "viins";
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      history = {
        extended = true;
        ignoreSpace = true;
        share = true;
        };
      };
      #vim = {
        #enable = true;
        #defaultEditor = false;
        #plugins = with pkgs.vimPlugins; [vim-shellcheck vim-go vim-git];
        #settings = {
          #expandtab = true;
          #mousehide = false;
        #};
        #extraConfig = ''
          #set nocompatible
          #set nobackup '';
      #};
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
          #todotxt.extensionUuid
          #toggle-alacritty.extensionUuid
          #wireguard-vpn-extension.extensionUuid
          wireless-hid.extensionUuid
          wifi-qrcode.extensionUuid
          ];
        favorite-apps = ["org.gnome.Nautilus.desktop" "librewolf.desktop" "Alacritty.desktop" "org.gnome.Console.desktop" "code.desktop" "org.gnome.Calendar.desktop" "nixos-manual.desktop" "org.gnome.Weather.desktop" "org.gnome.Settings.desktop"];
        };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
        };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "alacritty terminal";
        command = "alacritty";
        binding = "<Super>Return";
        };
      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        };
      };
    };
  };
}
