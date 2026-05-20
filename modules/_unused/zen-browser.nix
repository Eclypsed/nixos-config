{
  inputs,
  ...
}:
{
  flake.modules.homeManager.zen-browser =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.twilight
      ];

      programs.zen-browser =
        let
          mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

          mkExtensionEntry =
            {
              id,
              pinned ? false,
            }:
            let
              base = {
                install_url = mkPluginUrl id;
                installation_mode = "force_installed";
              };
            in
            if pinned then base // { default_area = "navbar"; } else base;

          mkExtensionSettings = builtins.mapAttrs (
            _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
          );
        in
        {
          enable = true;
          setAsDefaultBrowser = true;
          languagePacks = [ "en-US" ];
          policies = {
            DefaultDownloadDirectory = config.xdg.userDirs.download;
            DisableFirefoxAccounts = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableProfileImport = true;
            DisableProfileRefresh = true;
            DisableTelemetry = true;
            DisplayBookmarksToolbar = "never";
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
              Value = true; # Tracking protection is enabled by default in both the regular browser and private browsing
              Locked = true; # Whether or not a user can change tracking protection
              Cryptomining = true; # Block cryptomining scripts
              Fingerprinting = true; # Block fingerprinting scripts
              EmailTracking = true; # Block email tracking pixels and scripts
            };
            ExtensionSettings = mkExtensionSettings {
              "uBlock0@raymondhill.net" = mkExtensionEntry {
                id = "ublock-origin";
                pinned = true;
              };
              "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
            };
            FirefoxSuggest = {
              WebSuggestions = true;
              SponsoredSuggestions = false;
              ImproveSuggest = false;
              Locked = true;
            };
            Homepage = {
              URL = "http://100.78.212.35:30054";
              Locked = true;
              StartPage = "homepage";
            };
            OfferToSaveLogins = false;
            OverrideFirstRunPage = "";
            PasswordManagerEnabled = false;
            PopupBlocking = {
              Default = false;
              Locked = true;
            };
            Preferences = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            };
            PrimaryPassword = false;
            SearchBar = "unified";
            ShowHomeButton = true;
            SkipTermsOfUse = true;
          };
          profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            settings = {
              # Auto-enable extensions
              "extensions.autoDisableScopes" = 0;
            };
            search = {
              force = true;
              default = "google";
              engines =
                let
                  nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                in
                {
                  nix-packages = {
                    name = "Nix Packages";
                    urls = [
                      {
                        template = "https://search.nixos.org/packages";
                        params = [
                          {
                            name = "channel";
                            value = "unstable";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    icon = nixSnowflakeIcon;
                    definedAliases = [ "@np" ];
                  };
                  nix-options = {
                    name = "Nix Options";
                    urls = [
                      {
                        template = "https://search.nixos.org/options";
                        params = [
                          {
                            name = "channel";
                            value = "unstable";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    icon = nixSnowflakeIcon;
                    definedAliases = [ "@no" ];
                  };
                  home-manager = {
                    name = "Home Manager";
                    urls = [
                      {
                        template = "https://home-manager-options.extranix.com";
                        params = [
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];
                    icon = nixSnowflakeIcon;
                    definedAliases = [ "@hm" ];
                  };
                  surugaya = {
                    name = "Surugaya";
                    urls = [
                      {
                        template = "https://www.suruga-ya.jp/search?search_word={searchTerms}";
                      }
                    ];
                    iconMapObj."16" = "https://www.suruga-ya.jp/drupal/themes/surugaya/favicon.ico";
                    definedAliases = [ "@suru" ];
                  };
                };
            };
          };
        };
    };
}
