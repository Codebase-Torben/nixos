{
  config,
  pkgs,
  ...
}: {
  # Git Konfiguration
  programs = {
    gh-dash.enable = true;
    gitui.enable = true;
    #lazygit.enable = true;
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    git = {
      enable = true;
      userName = lib.mkForce "Git Signing";
      userEmail = lib.mkForce "torben@nixbook";
      signing = {
        signByDefault = lib.mkForce false;
        key = lib.mkForce "~/.ssh/schluessel4git.pub";
      };
      extraConfig = {
        protocol = {
          allow = "never";
          file.allow = "always";
          git.allow = "never";
          ssh.allow = "always";
          http.allow = "never";
          https.allow = "never";
        };
      };
    };
  };
}
