let
  framework13 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPB2mEQiWnZ0fg4QrHnt0N+/vsKV893AGMs8nQ5WIZSp";
  systems = [ framework13 ];
in
{
  "eclypsecloud-credentials.age".publicKeys = systems;
}
