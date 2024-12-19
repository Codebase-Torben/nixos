{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Bootvorgang
  boot = {
    blacklistedKernelModules = ["b43" "bcma" "brcmsmac" "ssb"];
    kernelParams = lib.mkForce ["hid_apple.swap_opt_cmd=1" "hid_apple.iso_layout=0" "intel_iommu=on"];
    initrd = {
      availableKernelModules = lib.mkForce [
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
    facetimehd.enable = lib.mkForce false;
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
    mbpfan.enable = lib.mkForce true;
  };

  # env
  environment = {
    systemPackages = with pkgs; [libsmbios];
  };
}
