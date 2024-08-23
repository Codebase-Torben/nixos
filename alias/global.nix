{config, ...}: {
  # Shell Aliase #
  environment = {
    shellAliases = {
      # NixOS Aliase
      "nix.build" = ''
        cd / &&\
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo alejandra --quiet . &&\
        export ZTSTMPL="-$(date '+%Y-%m-%d--%H-%M')" ;\
        export HSTNM="$(hostname)" ;\
        echo "############# ---> NIXOS-REBUILD NixOS [$HSTNM-$ZTSTMPL] <--- ##################"
        sudo nixos-rebuild boot -v --fallback --flake "/etc/nixos/.#$HSTNM" -p "$HSTNM-$ZTSTMPL" '';
      "nix.repair" = '' 
        cd / &&\      
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo nix-store --gc ;\
        sudo nix-store --verify --check-contents --repair'';
      "nix.clean" = ''
        cd / &&\        
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 13d ;\
        sudo nix-collect-garbage --delete-older-than 13d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      "nix.cleanfull" = ''
        cd / &&\        
        cd /etc/nixos &&\
        sudo -v &&\
        sudo rm /boot/loader/entries/nixos* ;\
        sudo rm -rf /nix/var/nix/profiles/system* ;\
        sudo mkdir -p /nix/var/nix/profiles/system-profiles ;\
        nix.build &&\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1d ;\
        sudo nix-collect-garbage --delete-older-than 1d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      "nix.test" = ''
        cd / &&\
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo alejandra --quiet . ;\
        sudo nixos-rebuild dry-activate --flake /etc/nixos/.#$(hostname)'';
      "nix.update" = ''
        cd / &&\
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo alejandra --quiet . &&\
        sudo chown -R me:users .git &&\
        sudo nix flake lock --update-input nixpkgs --update-input nixpkgs-Release --update-input home-manager ;\
        sudo alejandra --quiet .'';
      # Globale Aliase
      ed = "sudo nano";
      cro = "systemctl status chronyd ; chronyc tracking ; chronyc sources ; chronyc sourcestats ; sudo chronyc authdata ; sudo chronyc serverstats";
      termshark = "sudo termshark";
      l = "ls -la";
      ll = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename";
      la = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=size";
      lt = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename --tree";
      lo = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=filename --octal-permissions";
      li = "eza --all --long --total-size --group-directories-first --header --git --git-repos --sort=inode --inode";
      meow = "kittysay";
      b = "btop";
      h = "htop --tree --highlight-changes";
      slog = "journalctl --follow --priority=7 --lines=2500";
    };
  };
}
