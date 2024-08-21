{
  config,
  lib,
  modulesPath,
  ...
}: {
  # Import
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot
  boot = {
    # kernelParams = ["brcmfmac.feature_disable=0x82000"];
    # kernelParams = ["hid_apple.iso_layout=0"];
    kernelParams = ["hid_apple.swap_opt_cmd=1"];
    initrd = {
      availableKernelModules = [
        "applespi"
        "applesmc"
        "spi_pxa2xx_platform"
        "intel_lpss_pci"
      ];
    };
  };

  # Hardware
  hardware = {
    facetimehd.enable = lib.mkForce false;
  };

  # Netzwerk
  networking = {
    enableB43Firmware = true;
  };

  # Dienste
  services = {
    mbpfan.enable = true;
  };
}
