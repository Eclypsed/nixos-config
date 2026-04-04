{
  lib,
  python3Packages,
  fetchPypi,
  libadwaita,
  gtk4,
  wrapGAppsHook4,
  gobject-introspection,
  ...
}:
with python3Packages;

buildPythonApplication rec {
  pname = "monique";
  version = "0.5.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-fA2mVMjAg1vOpHPJr2B0NtJ00cEs23/Y4S4h3WurpY4=";
  };

  pyproject = true;
  build-system = [ setuptools ];

  nativeBuildInputs = [
    wrapGAppsHook4
    gobject-introspection
  ];

  buildInputs = [
    libadwaita
    gtk4
  ];

  propagatedBuildInputs = [
    pygobject3
  ];

  meta = {
    description = "Graphical monitor configurator for Hyprland and Sway";
    homepage = "https://github.com/ToRvaLDz/monique";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
