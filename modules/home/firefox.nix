{
  config,
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    nativeMessagingHosts = with pkgs; [
      kdePackages.plasma-browser-integration
    ];
    policies = {
      DefaultDownloadDirectory = config.xdg.userDirs.download;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true; # Tracking protection is enabled by default in both the regular browser and private browsing
        Locked = true; # Whether or not a user can change tracking protection
        Cryptomining = true; # Block cryptomining scripts
        Fingerprinting = true; # Block fingerprinting scripts
        EmailTracking = true; # Block email tracking pixels and scripts
      };
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = true;
        Locked = true;
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
      PrimaryPassword = false;
      SearchBar = "unified";
      ShowHomeButton = true;
      SkipTermsOfUse = true;
    };
    profiles.eclypse = {
      name = "Eclypse";
      isDefault = true;
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          plasma-integration
        ];
        settings = {
          "uBlock0@raymondhill.net".settings = {
            selectedFilterLists = [
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
              "ublock-quick-fixes"
            ];
          };
        };
      };
      search = {
        default = "google";
        force = true;
        engines = {
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
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          chat-gpt = {
            name = "ChatGPT";
            urls = [
              {
                template = "https://chatgpt.com?q={searchTerms}&temporary-chat=true";
              }
            ];
            iconMapObj."64" = "https://chatgpt.com/favicon.ico";
            definedAliases = [ "@gpt" ];
          };
          surugaya = {
            name = "Surugaya";
            urls = [
              {
                template = "https://www.suruga-ya.jp/search?search_word={searchTerms}";
              }
            ];
            iconMapObj."32" =
              "https://www.suruga-ya.jp/drupal/themes/surugaya_mobile/images/pwa/images/icons/favicon-32x32.png";
            definedAliases = [ "@suru" ];
          };
        };
      };
      settings = {
        # Auto-enable extensions
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
