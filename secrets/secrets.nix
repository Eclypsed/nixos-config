# This file is NOT imported into the nix configuration, it is just for the agenix CLI
let
  # System public ssh keys (/etc/ssh/)
  vanta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaDVBJdMDFL8r9NQCbaLe+DPHGhGzRv2N7+7m1/U8DP";
in
{
  # Tailscale auth key need to be up to date with a valid auth key in the tailscale
  # dashboard. Single-use keys expire after a single machine connects, and even
  # reusable keys expire after 90 days.
  # Update tailscale-auth.age with `agenix -e tailscale-auth.age -i /path/to/private-ssh-key`
  # Note: Only devices with the below public keys are allowed to edit tailscale-auth.age
  "tailscale-auth.age".publicKeys = [ vanta ]; # Devices allowed to join the tailnet;

  # Devices that can connect to EclypseCloud with the eclypse user.
  "eclypsecloud-eclypse.age".publicKeys = [ vanta ];

  # Devices that have the eclypse user
  "eclypse-password.age".publicKeys = [ vanta ];
}
