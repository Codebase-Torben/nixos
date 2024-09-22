{
  config,
  pkgs
  ...
}: {

  # Git Konfiguration
  programs = {
    git = {
      enable = true;
      prompt.enable = true;
      config = {
        branch.sort = "-committerdate";
        commit.gpgsign = true;
        init.defaultBranch = "main";
        safe.directory = "/home/torben/safegit";
        #safe.directory = "/etc/nixos";
        gpg.format = "ssh";
        user = {
          email = "torben@nixbook";
          name = "Git Signing";
          signingkey = "~/.ssh/schluessel4git.pub";
        };
      http = {
        sslVerify = "true";
        sslVersion = "tlsv1.3";
        version = "HTTP/1.1";
        };
        protocol = {
          allow = "never";
          file.allow = "always";
          git.allow = "never";
          ssh.allow = "always";
          http.allow = "never";
          https.allow = "always";
        };
      };
    };
  };
}
