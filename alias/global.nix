{config, ...}: {
  # Shell Aliase #
  environment = {
    shellAliases = {
      # Aliase
      etcnix = "cd / && cd /etc/nixos";
      homet = "cd / && cd /home/torben";
      "neubauen" = ''
        etcnix ;\
        export ZTSTMPL="$(date '+%d-%m-%Y_%H-%M')" ;\
        echo " " ;\
        echo "############# ---> Dein NixOS wird gebaut (NixOS_Luna_v1.0x_$ZTSTMPL) <--- ##################" ;\
        echo " " ;\
        sudo nixos-rebuild boot -v --fallback --flake "/etc/nixos/flake.nix" -p "NixOS_Luna_v1.0x_$ZTSTMPL" '';
      "storecheck" = ''             
        etcnix ;\
        sudo nix-store --gc ;\
        sudo nix-store --verify --check-contents --repair '';
      "clean6" = ''
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
        echo " " ;\
        echo "!!! Achtung, es wurden alle Profile gelöscht. Es muss mindestens einen Rebuild geben." ;\
        echo " " ;\
        sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1d ;\
        sudo nix-collect-garbage --delete-older-than 1d ;\
        sudo nix-store --gc ;\
        sudo nix-store --optimise '';
      testbuild = "sudo nixos-rebuild dry-activate -v";
      ed = "sudo nano";
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
      time = "timedatectl && timedatectl timesync-status";
      slog = "journalctl --follow --priority=7 --lines=2500";
    };
  };
}
