{config, ...}: {
  # Shell Aliase #
  environment = {
    shellAliases = {
      # Aliase

      # Bauen
      "testbuild" = ''
        etcnix ;\
        export HNAME="$(hostname)" ;\
        clear ;\
        sudo nix flake update -v ;\
        echo " " ;\
        echo "-------------> Es wird ein Build versucht... Bitte warten... <-------------" &&\
        sudo nom build .#nixosConfigurations.$HNAME.config.system.build.toplevel ;\
        sudo rm -f result ;\
        sudo nixos-rebuild dry-activate --flake "/etc/nixos/.#$HNAME" '';
      "neubauen" = ''
        etcnix ;\
        export ZTSTMPL="$(date '+%d-%m-%Y-%H-%M')" ;\
        export HNAME="$(hostname)" ;\
        clear ;\
        sudo nix flake update -v ;\
        echo " " ;\
        echo "-------------> Dein NixOS Luna wird gebaut ($ZTSTMPL) <-------------" &&\
        sudo nom build .#nixosConfigurations.$HNAME.config.system.build.toplevel ;\
        sudo rm -f result ;\
        sudo nixos-rebuild boot --flake "/etc/nixos/.#$HNAME" -p "NixOS-Luna-vom-$ZTSTMPL" '';

      # Nix Store
      "storecheck" = ''           
        etcnix ;\
        sudo nix-store -v --gc ;\
        sudo nix flake check -v '';
      "storeupdate" = ''           
        etcnix ;\
        sudo nix-store -v --gc ;\
        sudo nix-store -v --verify --check-contents --repair ;\
        sudo nix flake check -v ;\
        sudo nix flake update -v '';

      # Profile
      "cleanix" = ''
        etcnix ;\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 6d ;\
        sudo nix-collect-garbage --delete-older-than 6d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      "cleanall" = ''
        etcnix ;\
        sudo rm /boot/loader/entries/nixos* ;\
        sudo rm -rf /nix/var/nix/profiles/system* ;\
        sudo mkdir -p /nix/var/nix/profiles/system-profiles ;\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1d ;\
        sudo nix-collect-garbage --delete-older-than 1d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise ;\
        neubauen '';

      # Sicherung
      "savehome" = ''
        export USBSTORE="$(ls /var/run/media/torben)" ;\
        export ZTSTMPL="$(date '+%d-%m-%Y-%H-%M')" ;\
        tar czfv /var/run/media/torben/$USBSTORE/NixOS/home_$ZTSTMPL.tar.gz --directory=/home/torben --exclude='*.qcow2' --exclude='*.iso' . '';
      "savevarlib" = ''
        export USBSTORE="$(ls /var/run/media/torben)" ;\
        export ZTSTMPL="$(date '+%d-%m-%Y-%H-%M')" ;\
        sudo tar czfv /var/run/media/torben/$USBSTORE/NixOS/varlib_$ZTSTMPL.tar.gz --directory=/var/lib --exclude='*.qcow2' --exclude='*.iso' . '';

      # Quality of life
      b = "btop";
      ed = "sudo nano";
      etcnix = "cd / && cd /etc/nixos";
      homenix = "cd / && cd /home/torben/Dokumente/nixos";
      h = "htop --tree --highlight-changes";
      l = "ls -la";
      ll = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename";
      la = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=size";
      lt = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename --tree";
      lo = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename --octal-permissions";
      li = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=inode --inode";
      meow = "kittysay";
      termshark = "sudo termshark";
      time = "timedatectl && chronyc tracking && chronyc activity";

      # Services
      logbuch = "journalctl --since='30 min ago' -u $(systemctl list-units --type=service | fzf | sed 's/●/ /g' | cut --fields 3 --delimiter ' ')";
      neustarter = "sudo systemctl restart $(systemctl list-units --type=service | fzf | sed 's/●/ /g' | cut --fields 3 --delimiter ' ')";
      starter = "sudo systemctl start $(systemctl list-units --type=service --all | fzf | sed 's/●/ /g' | cut --fields 3 --delimiter ' ')";
      stopper = "sudo systemctl stop $(systemctl list-units --type=service | fzf | sed 's/●/ /g' | cut --fields 3 --delimiter ' ')";
    };
  };
}
