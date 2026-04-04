{
  lib,
  python3Packages,
  fetchurl,
  ...
}:
with python3Packages;

buildPythonApplication rec {
  pname = "pywalfox-native";
  version = "2.8.0rc1";
  pyproject = true;

  src = fetchurl {
    url = "https://test-files.pythonhosted.org/packages/89/a1/8e011e2d325de8e987f7c0a67222448b252fc894634bfa0d3b3728ec6dbf/pywalfox-${version}.tar.gz";
    sha256 = "sha256-ieDXpEHrYAkzRAxxPN2/rs2iNr3n8/ZV2w7CCwrhKEU=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "pywalfox" ];

  meta = {
    description = " Native app used alongside the Pywalfox addon";
    homepage = "https://github.com/Frewacom/pywalfox-native";
    license = lib.licenses.mpl20;
  };
}
