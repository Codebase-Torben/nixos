{config, ...}: {
  # Shell Aliase #
  environment = {
    shellAliases = {
      "nix.build" = ''
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
      #"nix.cacheall" = ''
        #cd /etc/nixos &&\
        #nix.update ;\
        #cd && mkdir -p cache && cd cache &&\
        #nixos-rebuild build -v --fallback --flake /etc/nixos/#FLAKE ;\
      #"nix.gitpush" = ''
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
      "nix.repair" = ''
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo nix-store --gc ;\
        sudo nix-store --verify --check-contents --repair'';
      "nix.clean" = ''
        cd /etc/nixos &&\
        env sudo -v &&\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 12d ;\
        sudo nix-collect-garbage --delete-older-than 12d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      "nix.cleanfull" = ''
        cd /etc/nixos &&\
        sudo -v &&\
        sudo rm /boot/loader/entries/* ;\
        sudo rm -rf /nix/var/nix/profiles/system* ;\
        sudo mkdir -p /nix/var/nix/profiles/system-profiles ;\
        nix.build &&\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1d ;\
        sudo nix-collect-garbage --delete-older-than 1d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      #"nix.test" = ''
        #cd /etc/nixos &&\
        #env sudo -v &&\
        #sudo alejandra --quiet . ;\
        #git reset ;\
        #git add . ;\
        #git commit -S -m update ;\
        #sudo nixos-rebuild dry-activate --flake /etc/nixos/.#$(hostname)'';
      #"nix.update" = ''
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
    };
  };
}