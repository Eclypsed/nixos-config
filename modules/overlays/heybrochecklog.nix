self: super: with super.python3Packages;
let
  pprp = buildPythonPackage rec {
    pname = "pprp";
    version = "0.2.7";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-2ednecxSsJONvH9XJ6GV3ExgdcPrUEAlYRpZt2Nrkw0=";
    };

    format = "setuptools";
    doCheck = false;
  };
in
{
  heybrochecklog = buildPythonApplication {
    pname = "heybrochecklog";
    version = "1.4.7";

    src = super.fetchurl {
      url = "https://github.com/doujincafe/hbcl/releases/download/v1.4.7/heybrochecklog-1.4.7.tar.gz";
      sha256 = "sha256-nCJJvzw/BoCEGDIX62zZr1ZI/b0W5nnFOZlMw4Btcnw=";
    };

    format = "pyproject";
    doCheck = false;

    nativeBuildInputs = [
      poetry-core
    ];

    propagatedBuildInputs = [
      faust-cchardet
      chardet
      pprp
    ];

    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace 'poetry.masonry.api' 'poetry.core.masonry.api' \
        --replace 'poetry>=' 'poetry-core>='
    '';
  };
}
