{
  config,
  pkgs,
  ...
}: {
  # Dienste
  services = {
    memcached = {
      enable = true;
      maxConnections = 128;
      maxMemory = 512; # mb
    };
  };
  # Docker Container
  virtualisation = {
    oci-containers = {
      backend = "podman";
      containers = {
        speed = {
          image = "openspeedtest/latest:latest";
          ports = ["0.0.0.0:7891:3000"];
          autostart = true;
          #environment = {
            #SET_SERVER_NAME = "speedtest.pinasse.home";
          #};
        };
        yo = {
          image = "jhaals/yopass:latest";
          cmd = ["--address=0.0.0.0" "--port=7892" "--metrics-port=9144" "--database=memcached" "--memcached=localhost:11211"];
          extraOptions = ["--network=host"];
          autostart = true;
        };
        status = {
          image = "adamboutcher/statping-ng:latest";
          ports = ["0.0.0.0:7893:4000"];
          autostart = true;
        };
        chef = {
          image = "ghcr.io/gchq/cyberchef:latest";
          ports = ["0.0.0.0:7894:80"];
          autostart = true;
        };
        whoogle = {
          image = "benbusby/whoogle-search:latest";
          ports = ["0.0.0.0:8080:8080"];
          autostart = true;
          environment = {
            EXPOSE_PORT = "8080";
            WHOOGLE_MINIMAL = "1";
            WHOOGLE_RESULTS_PER_PAGE = "200";
            WHOOGLE_CONFIG_LANGUAGE = "de";
            WHOOGLE_CONFIG_SEARCH_LANGUAGE = "de";
            WHOOGLE_CONFIG_SAFE = "1";
            WHOOGLE_CONFIG_URL = "http://localhost:8080";
          };
        };
      };
    };
  };
}