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
      "10.0.2.146" = ["Vindows11" "pinasse.home"];
    };
    nftables.enable = lib.mkForce false;
    firewall.trustedInterfaces = ["virbr1"];
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
      allowedBridges = ["virbr1"];
      onBoot = "start";
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
