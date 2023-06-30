{ pkgs, ... }:
let
	orcaSlicer = pkgs.appimageTools.wrapType2 {
		name = "OrcaSlicer";
		# Having some issues with zip, maybe proxy to AppImage directly? (direct download seems fine..)
		src = pkgs.fetchzip {
			url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v1.6.3/OrcaSlicer_V1.6.3_Linux.zip";
			# url = "https://github.com/bambulab/BambuStudio/releases/download/v01.06.02.04/Bambu_Studio_linux_ubuntu_v01.06.02.04-20230427094209.AppImage"; # Bambu for testing appimage directly
			# hash = "sha256-J5lwGmRj2qU2E2xgbL40sIN/IinSIqt9PcViP9yiRjc=";
			hash = "sha256-n/D0qfli+kPPKgDIujsPdZHdoUPex3SFuSqLlhGzxJY=";
			# hash = "sha256-8daajQTWROZ2q4ZPU3ooJHz1Aar99aLj/2y9a4gvMKE=";
			# downloadToTemp = true;
			# postFetch = ''
			# 	${pkgs.unzip}/bin/unzip -p $downloadedFile OrcaSlicer_ubu64.AppImage > $out
			# '';
		};
		extraPkgs = pkgs: with pkgs; [
			webkitgtk
			gcc12
		];
	};
in {
	home.packages = [
		# orcaSlicerpkgs
		pkgs.prusa-slicer
	];
}
