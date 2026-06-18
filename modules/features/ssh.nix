{
  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/id_ed25519_sk_rk";
        };
        "stu" = {
          Hostname = "stu.cs.jmu.edu";
          User = "tamassno";
          LocalForward = [
            {
              bind.port = 5432;
              host = {
                address = "data.cs.jmu.edu";
                port = 5432;
              };
            }
          ];
          ServerAliveCountMax = 5;
          ServerAliveInterval = 60;
        };
        "cluster" = {
          Hostname = "login02.cluster.cs.jmu.edu";
          User = "tamassno";
          ProxyJump = "stu";
        };
        "kbr-azure-devops" = {
          Hostname = "bwi-tfs.wyle.com";
          User = "git";
          IdentityFile = "~/.ssh/id_rsa";
          IdentitiesOnly = "yes";
        };
      };
    };
  };
}
