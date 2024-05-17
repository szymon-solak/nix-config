# TODO: FIXME
{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    package = pkgs.firefox-devedition;
    enable = true;
    profiles.default = {
      bookmarks = {};
      # extensions = with inputs.firefox-addons; [
      # ublock-origin
      # bitwarden
      # react-devtools
      # reduxdevtools
      # ];
      settings = {
        "browser.startup.homepage" = "file:///~/projects/start-page/index.html";
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };
}
