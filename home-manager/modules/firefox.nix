{ pkgs, ... }:
{
	programs.firefox = {
		enable = true;
		package = pkgs.wrapFirefox pkgs.firefox-devedition-unwrapped {
			nixExtensions = [
				(pkgs.fetchFirefoxAddon {
					name = "ublock";
					url = "https://addons.mozilla.org/firefox/downloads/file/4188488/ublock_origin-1.53.0.xpi";
					# TODO: Wrong hash
					hash = "sha256-2e73AbmYZlZXCP5ptYVcFjQYdjDp4iPoEPEOSCVF5sA=";
				})
				# TODO: Bitwarden
				# TODO: React dev tools
			];

			extraPolicies = {
				CaptivePortal = false;
				DisableFirefoxStudies = true;
				DisablePocket = true;
				DisableTelemetry = true;
				DisableFirefoxAccounts = false;
				NoDefaultBookmarks = true;
				OfferToSaveLogins = false;
				OfferToSaveLoginsDefault = false;
				PasswordManagerEnabled = false;
				FirefoxHome = {
						Search = true;
						Pocket = false;
						Snippets = false;
						TopSites = false;
						Highlights = false;
				};
				UserMessaging = {
						ExtensionRecommendations = false;
						SkipOnboarding = true;
				};
			};
		};
	};
}
