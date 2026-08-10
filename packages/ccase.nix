{
  lib,
  fetchFromGitHub,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "ccase";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "stringcase";
    repo = "ccase";
    tag = finalAttrs.version;
    hash = "sha256-VkykOOMHUsJhfktNRfHx+kvB2331PPhT5pW5bX+kLng=";
  };

  cargoHash = "sha256-gi7CR5UUD+qUQ6wx0XepzyHHq9RH7SnsMXIKV4JoiQg=";

  meta = {
    description = "Command line interface to convert strings into any case.";
    homepage = "https://github.com/stringcase/ccase";
    mainProgram = finalAttrs.pname;
    license = lib.licenses.mit;
  };
})
