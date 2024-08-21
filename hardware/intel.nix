{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.hardware.intelgpu.driver = lib.mkOption {
    description = "Intel GPU driver to use";
    type = lib.types.enum [
      "i915"
    ];
    default = "i915";
  };

  options.hardware.intelgpu.loadInInitrd =
    lib.mkEnableOption (
      lib.mdDoc "Intel GPU Kernelmodule laden (stage 1 boot)"
    )
    // {
      default = true;
    };

  config = {
    boot.initrd.kernelModules = [ config.hardware.intelgpu.driver ];

    environment.variables = {
      VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
    };

    hardware.graphics.extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-driver
    ];

    hardware.graphics.extraPackages32 = with pkgs.driversi686Linux; [
      intel-vaapi-driver
      intel-media-driver
    ];
  };
}
