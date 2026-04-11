{
  inputs,
  ...
}:
{
  flake.modules.nixos.monique = {
    imports = [ inputs.monique.nixosModules.default ];

    programs.monique.enable = true;
  };
}
