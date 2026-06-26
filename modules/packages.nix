{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem =
    {
      config,
      system,
      pkgs,
      final,
      ...
    }:
    let
      python-extensions = python-final: python-prev: {
        pprp = python-final.callPackage "${inputs.packages}/pprp.nix" { };
      };
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          (final: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [ python-extensions ];
          })
        ];
      };
      packages = {
        heybrochecklog = pkgs.callPackage "${inputs.packages}/heybrochecklog.nix" { };
        pywalfox-native = pkgs.callPackage "${inputs.packages}/pywalfox-native.nix" { };
      };
      overlayAttrs = {
        inherit (config.packages)
          heybrochecklog
          pywalfox-native
          ;

        pythonPackagesExtensions = pkgs.pythonPackagesExtensions ++ [ python-extensions ];

        disktui = pkgs.disktui.overrideAttrs (oldAttrs: {
          nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ final.makeWrapper ];

          postInstall = (oldAttrs.postInstall or "") + ''
            wrapProgram $out/bin/disktui \
              --prefix PATH : ${
                final.lib.makeBinPath (
                  with final;
                  [
                    # Required
                    parted # partition management
                    util-linux # partition resizing
                    e2fsprogs # ext4 filesystem support
                    cryptsetup # LUKS encryption support
                    # Optional
                    dosfstools # FAT32 filesystem support
                    ntfs3g # NTFS filesystem support
                    exfatprogs # exFAT filesystem support
                    btrfs-progs # Btrfs filesystem support
                    xfsprogs # XFS filesystem support
                    smartmontools # SMART disk health monitoring
                  ]
                )
              }
          '';
        });
      };
    };
}
