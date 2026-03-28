self: super: with super.python3Packages; {
  monique = buildPythonApplication rec {
    pname = "monique";
    version = "0.5.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-fA2mVMjAg1vOpHPJr2B0NtJ00cEs23/Y4S4h3WurpY4=";
    };

    pyproject = true;
    build-system = [ setuptools ];

    nativeBuildInputs = [
      super.wrapGAppsHook4
      super.gobject-introspection
    ];

    buildInputs = [
      super.libadwaita
      super.gtk4
    ];

    propagatedBuildInputs = [
      pygobject3
    ];
  };
}
