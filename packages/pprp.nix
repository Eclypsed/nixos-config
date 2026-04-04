{
  lib,
  buildPythonPackage,
  fetchPypi,
  ...
}:

buildPythonPackage rec {
  pname = "pprp";
  version = "0.2.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-2ednecxSsJONvH9XJ6GV3ExgdcPrUEAlYRpZt2Nrkw0=";
  };

  format = "setuptools";
  doCheck = false;

  pythonImportsCheck = [ "pprp" ];

  meta = {
    description = "A pure-Python Rijndael (AES) and PBKDF2 library";
    homepage = "https://github.com/dsoprea/RijndaelPbkdf";
    license = lib.licenses.gpl2;
  };
}
