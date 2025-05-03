{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eclypse = {
    isNormalUser = true;
    description = "Eclypse";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
