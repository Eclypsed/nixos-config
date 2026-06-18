{
  lib,
  rustPlatform,
  python3Packages,
  fetchPypi,
  ...
}:
with python3Packages;

buildPythonApplication rec {
  pname = "sysand";
  version = "0.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-97hkRSh31LBrZ+9/XaIUKdkMq9oicV7risjIVsrfqVE=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-prvNUY5rGsQToCjVXjQ4PrKG+T59q13emvS/7US8pfM=";
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
  ];

  meta = {
    description = "A package manager for SysML v2 and KerML";
    homepage = "https://github.com/sensmetry/sysand";
    license = lib.licenses.mit;
  };
}
