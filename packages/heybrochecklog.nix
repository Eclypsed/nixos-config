{
  lib,
  python3Packages,
  fetchFromGitHub,
  ...
}:
with python3Packages;

buildPythonApplication rec {
  pname = "heybrochecklog";
  version = "v1.4.7";

  src = fetchFromGitHub {
    owner = "doujincafe";
    repo = "hbcl";
    rev = version;
    sha256 = "sha256-LB2Xn6oS3iBL/+1vMRuj0cmRc9tRiCjgJ5axm4tYkdg=";
  };

  format = "pyproject";
  doCheck = false;

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    faust-cchardet
    chardet
    pprp # Comes from the overlay, not part of nixpkgs
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'poetry.masonry.api' 'poetry.core.masonry.api' \
      --replace 'poetry>=' 'poetry-core>='
  '';

  meta = {
    description = "A doujin café discord community maintained log checker";
    homepage = "https://github.com/doujincafe/hbcl";
    license = lib.licenses.asl20;
  };
}
