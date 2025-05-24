{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    package = pkgs.firefox;

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisplayMenuBar = "default-off";
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      OfferToSaveLogins = false;
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      ExtensionUpdate = false;
    };

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      bookmarks = {};

      extensions = [
        pkgs.nur.repos.rycee.firefox-addons.ublock-origin
        pkgs.nur.repos.rycee.firefox-addons.bitwarden
        pkgs.nur.repos.rycee.firefox-addons.react-devtools
        pkgs.nur.repos.rycee.firefox-addons.reduxdevtools
        pkgs.nur.repos.rycee.firefox-addons.sidebery
        pkgs.nur.repos.rycee.firefox-addons.adaptive-tab-bar-colour
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.page" = 3;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "widget.gtk.ignore-bogus-leave-notify" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };

      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;

      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };
          "Kagi" = {
            urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
            definedAliases = ["@k"];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };
    };
  };
}
