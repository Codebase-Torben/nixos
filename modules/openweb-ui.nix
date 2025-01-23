{config, ...}: {
  # Dienste
  services = {
    open-webui = {
      enable = true;
      host = "127.0.0.1";
      port = 6161;
      openFirewall = false;
    };
  };
}
