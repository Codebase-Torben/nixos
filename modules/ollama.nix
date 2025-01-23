{config, ...}: {
  # Dienste
  services = {
    ollama = {
      enable = true;
      # host = "127.0.0.1";
      # port = 11434;
      # openFirewall = false;
      # user = "ollama";
      # group = "ollama";
      # acceleration = false;
      # environmentVariables = [];
      # home = "";
      # models = "";
      # loadModels = [];
      # rocmOverrideGfx = "";
    };
  };

  # env
  environment = {
    shellAliases = {
      #ollama-commit = "/home/torben/.npm-packages/bin/ollama-commit --language de --api http://localhost:11434 --model mistral";
      tlm = "go run github.com/yusufcanb/tlm@latest $*";
      gollama = "go run github.com/sammcj/gollama@latest $*";
    };
  };
}
