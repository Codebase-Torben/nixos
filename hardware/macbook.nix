{
  config,
  lib,
  modulesPath,
  ...
}: {
  # Import
  imports = [
    # (modulesPath + "/hardware/network/broadcom-43xx.nix")
    # (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # nixpkgs
  nixpkgs = {
    config.allowUnfree = lib.mkDefault true;
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  # Boot
	boot = {
    blacklistedKernelModules = ["b43" "bcma" "brcmsmac" "ssb"];
    kernelParams = ["hid_apple.swap_opt_cmd=1" "hid_apple.iso_layout=0" "intel_iommu=on"];
    initrd = {
      availableKernelModules = [
        "applespi"
        "applesmc"
        "spi_pxa2xx_platform"
        "intel_lpss_pci"
        "kvm-intel"
      ];
    };
  };

  # Hardware
  hardware = {
    enableAllFirmware = lib.mkForce true;
    facetimehd.enable = lib.mkForce true;
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-ocl intel-media-driver];
    cpu = {
      intel = {
        updateMicrocode = lib.mkForce true;
        sgx.provision.enable = lib.mkForce false;
      };
    };
  };

  # Dienste
  services = {
    mbpfan.enable = true;
  };

  # env
  environment = {
    systemPackages = with pkgs; [libsmbios];
  };
}
