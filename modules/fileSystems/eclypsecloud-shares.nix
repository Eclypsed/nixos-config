{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.eclypsecloud-shares =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = with self.factory.nixos; [
        (cifs {
          destination = "/mnt/EclypseCloud";
          host = "100.78.212.35";
          resource = "EclypseCloud";
          credentialsPath = config.age.secrets.eclypsecloud-eclypse.path;
          uid = config.users.users.eclypse.uid;
        })
        (cifs {
          destination = "/mnt/Music";
          host = "100.78.212.35";
          resource = "music";
          credentialsPath = config.age.secrets.eclypsecloud-eclypse.path;
          uid = config.users.users.eclypse.uid;
        })
      ];

      age.secrets.eclypsecloud-eclypse.rekeyFile = "${inputs.secrets}/eclypsecloud-eclypse.age";

      environment.systemPackages = with pkgs; [
        cifs-utils
      ];
    };
}
