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
        sudo chown -R torben:users .git &&\
        #git reset &&\
        #git add . &&\
        #git commit -S -m update ;\
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
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 12d ;\
        sudo nix-collect-garbage --delete-older-than 12d ;\
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
      #"nix.cacheall" = ''
      #cd / &&\
      #cd /etc/nixos &&\
      #nix.update ;\
      #cd && mkdir -p cache && cd cache &&\
      #nixos-rebuild build -v --fallback --flake /etc/nixos/#FLAKE ;\
      #"nix.gitpush" = ''
      #cd / &&\
      #cd /etc/nixos &&\
      #env sudo -v &&\
      #host github.com ;\
      #host api.github.com ;\
      #host cache.nixos.org ;\
      #sudo alejandra --quiet . &&\
      #sudo chown -R NAME:GROUP .git &&\
      #git reset &&\
      #git add . &&\
      #git commit -S -m update ;\
      #git fsck --full &&\
      #git gc --aggressive &&\
      #git push --force '';
      #"nix.test" = ''
      #cd / &&\
      #cd /etc/nixos &&\
      #env sudo -v &&\
      #sudo alejandra --quiet . ;\
      #git reset ;\
      #git add . ;\
      #git commit -S -m update ;\
      #sudo nixos-rebuild dry-activate --flake /etc/nixos/.#$(hostname)'';
      #"nix.update" = ''
      #cd / &&\
      #cd /etc/nixos &&\
      #env sudo -v &&\
      #sudo alejandra --quiet . &&\
      #sudo chown -R me:users .git &&\
      #git reset &&\
      #git add . &&\
      #git commit -S -m update ;\
      #git fsck --full &&\
      #git gc --aggressive &&\
      #sudo nix flake lock --update-input nixpkgs --update-input nixpkgs-Release --update-input home-manager ;\
      #sudo alejandra --quiet .'';
      #"nix.switch" = ''
      #nix.build ;\
      #sudo nixos-rebuild switch --flake "/etc/nixos/.#$HSTNM" -p "$HSTNM-$ZTSTMPL"'';
      #"nix.boot" = ''
      #nix.build &&\
      #sudo nixos-rebuild boot -v --fallback --install-bootloader '';
      #"nix.all" = ''
      #nix.update ;\
      #nix.build ;\
      #echo "############# ---> NIXOS-REBUILD **all** NixOS [$HSTNM-$ZTSTMPL] <--- ##########"
      #sudo nixos-rebuild boot -v --fallback --flake /etc/nixos/#nixos         -p "nixos-$ZTSTMPL" ;\
      #sudo nixos-rebuild boot -v --fallback --flake /etc/nixos/#nixos-console -p "nixos-console-$ZTSTMPL" ;\
      #sudo nixos-rebuild boot -v --fallback --flake /etc/nixos/#$HSTNM        -p "$HSTNM-$ZTSTMPL" '';
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
