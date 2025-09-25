self: super: with super.python3Packages; rec {
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

  heybrochecklog = buildPythonApplication rec {
    pname = "heybrochecklog";
    version = "1.4.7";

    src = super.fetchurl {
      url = "https://github.com/doujincafe/hbcl/releases/download/v${version}/heybrochecklog-${version}.tar.gz";
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
