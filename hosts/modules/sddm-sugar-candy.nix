{
  formats,
  qtbase,
  qtsvg,
  qtgraphicaleffects,
  qtquickcontrols2,
  stdenvNoCC,
  fetchFromGitHub,
  themeConfig ? null,
}: let
  user-cfg = (formats.ini {}).generate "theme.conf.user" themeConfig;
in
  stdenvNoCC.mkDerivation {
    pname = "sddm-sugar-candy";
    version = "1.6-config-v4";

    src = fetchFromGitHub {
      owner = "szymon-solak";
      repo = "sddm-sugar-candy";
      rev = "32a365add24adc2abadc47d41ab7c6b22806af4b";
      sha256 = "sha256-XNgdnZDYX/p4ZuFl5Po/jEbJBsngbSdrrsMNMjz9S3M=";
    };

    propagatedUserEnvPkgs = [
      qtbase
      qtsvg
      qtgraphicaleffects
      qtquickcontrols2
    ];

    installPhase = ''
          mkdir -p $out/share/sddm/themes/sugar-candy
      ln -sf ${user-cfg} $out/share/sddm/themes/sugar-candy/theme.conf.user
          cp -r $src/* $out/share/sddm/themes/sugar-candy/
    '';
  }
