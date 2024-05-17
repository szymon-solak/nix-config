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
  stdenvNoCC.mkDerivation rec {
    pname = "sddm-sugar-candy";
    version = "1.6-config-v3";

    src = fetchFromGitHub {
      owner = "Kangie";
      repo = "sddm-sugar-candy";
      rev = "a1fae5159c8f7e44f0d8de124b14bae583edb5b8";
      sha256 = "sha256-p2d7I0UBP63baW/q9MexYJQcqSmZ0L5rkwK3n66gmqM=";
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
