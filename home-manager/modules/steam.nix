{pkgs, ...}: let
  steam = pkgs.steam.override {
    extraPkgs = pkgs: [pkgs.gamescope pkgs.libkrb5 pkgs.keyutils];
  };
in {home.packages = [steam pkgs.steam-run];}
