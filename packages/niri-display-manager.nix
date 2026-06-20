{
  lib,
  fetchFromGitHub,
  python3Packages,
  qt6,
}:

python3Packages.buildPythonApplication rec {
  pname = "niri-display-manager";
  version = "0.8.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "rickycbanks";
    repo = "niri_display_manager";
    rev = "v${version}";
    hash = "sha256-tI2kUbSIVO0qL4nAni6Br0Mw46nq+pC3JnDbcEs8HGY=";
  };

  nativeBuildInputs = [
    python3Packages.hatchling
    qt6.wrapQtAppsHook
  ];

  dontWrapQtApps = true;

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
  ];

  propagatedBuildInputs = with python3Packages; [
    pyside6
    pyudev
  ];

  postPatch = ''
    substituteInPlace src/niri_display_manager/main.py \
      --replace-fail 'Path("/usr/share/niri-display-manager/qml")' \
                     'Path("${placeholder "out"}/share/niri-display-manager/qml")'
  '';

  postInstall = ''
    install -d $out/share/niri-display-manager
    cp -r qml $out/share/niri-display-manager/

    install -Dm644 packaging/io.github.rickycbanks.NiriDisplayManager.desktop \
      $out/share/applications/io.github.rickycbanks.NiriDisplayManager.desktop

    install -Dm644 assets/icons/niri-display-manager.svg \
      $out/share/icons/hicolor/scalable/apps/io.github.rickycbanks.NiriDisplayManager.svg

    install -d $out/lib/systemd/user
    substitute packaging/systemd/niri-display-manager-daemon.service \
      $out/lib/systemd/user/niri-display-manager-daemon.service \
      --replace-fail '%h/.local/bin/niri-display-manager' \
                     '${placeholder "out"}/bin/niri-display-manager'
  '';

  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  doCheck = false;

  meta = with lib; {
    description = "GUI display manager for the Niri window manager";
    homepage = "https://github.com/rickycbanks/niri_display_manager";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "niri-display-manager";
  };
}
