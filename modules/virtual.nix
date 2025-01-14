{
  config,
  pkgs,
  lib,
  ...
}: {
  # Boot
  boot = {
    kernelModules = ["kvm-intel" "kvm-amd"];
  };

  # Virtual Machine Mananger
  programs = {
    virt-manager.enable = true;
  };

  # Sicherheit
  security = {
    unprivilegedUsernsClone = lib.mkForce true;
  };

  # Netzwerk
  networking = {
    hosts = {
      "192.168.4.100" = ["Vindows" "pinasse.home"];
      #"192.168.xxx.xxx" = ["HOSTNAME" "pinasse.home"];
    };
    nftables.enable = lib.mkForce false;
    firewall.trustedInterfaces = ["virbr0"];
  };

  # env
  environment = {
    # systemPackages = with pkgs; [quickemu distrobox distrobox-tui dive spice spice-gtk spice-protocol virt-viewer];
    systemPackages = with pkgs; [spice spice-gtk spice-protocol virt-viewer];
  };

  # Virtualisierungsoptionen
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      allowedBridges = ["virbr0"];
      onBoot = "start";
      qemu = {
        package = pkgs.qemu_full;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
            .fd
          ];
        };
      };
    };
  };
}
