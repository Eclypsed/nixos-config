{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = [ "~/.ssh/id_ed25519_sk_rk" ];
      };
      "stu" = {
        hostname = "stu.cs.jmu.edu";
        user = "tamassno";
        localForwards = [
          {
            bind.port = 5432;
            host = {
              address = "data.cs.jmu.edu";
              port = 5432;
            };
          }
        ];
        serverAliveCountMax = 5;
        serverAliveInterval = 60;
      };
      "cluster" = {
        hostname = "login02.cluster.cs.jmu.edu";
        user = "tamassno";
        proxyJump = "stu";
      };
    };
  };
}
