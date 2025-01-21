{
  config,
  pkgs,
  lib,
  ...
}: {
  # Git Konfiguration
  home-manager.users.torben = {
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
        userName = lib.mkForce "cobebase-torbenix";
        userEmail = lib.mkForce "torben@nixbook";
        signing = {
          signByDefault = lib.mkForce false;
          key = lib.mkForce "~/.ssh/schluessel4git.pub";
        };
        extraConfig = {
          branch.sort = "-committerdate";
          commit.gpgsign = false;
          init.defaultBranch = "main";
          safe.directory = "~/safegit";
          gpg.format = "ssh";
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
  };
}
