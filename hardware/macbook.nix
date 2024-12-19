{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Bootvorgang
  #boot = {
    #blacklistedKernelModules = ["b43" "bcma" "brcmsmac" "ssb"];
    #kernelParams = lib.mkForce ["hid_apple.swap_opt_cmd=1" "hid_apple.iso_layout=0" "intel_iommu=on"];
    #initrd = {
      #availableKernelModules = lib.mkForce [
        #"applespi"
        #"applesmc"
        #"spi_pxa2xx_platform"
        #"intel_lpss_pci"
        #"kvm-intel"
      #];
    #};
  #};

  # Hardware
  hardware = {
    facetimehd.enable = lib.mkForce false;
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-ocl intel-media-driver];
  };

  # Dienste
  services = {
    mbpfan.enable = lib.mkForce true;
  };

  # Env
  environment = {
    systemPackages = with pkgs; [libsmbios];
  };
}