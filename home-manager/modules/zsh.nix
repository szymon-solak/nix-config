{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;

    shellAliases = {
      ip = "ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\\  -f2";
      ls = "exa";

      # Git
      gst = "git status";
      gc = "git commit -v";

      # Workaround to make fnm work in js shell - https://github.com/NixOS/nixpkgs/issues/202401
      node = "steam-run node";
      npm = "steam-run npm";
    };

    initExtra = ''
      export PATH=$HOME/bin:/usr/local/bin:$PATH
      export PATH=$HOME/.local/bin:$PATH
      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';

    plugins = with pkgs; [
      {
        name = "forgit";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "f6040b21a0db895d0e0ec110fecdc72274a20417";
          sha256 = "sha256-zyDp8tswi+6WuHgJkSIz1OE6s314qycK1975vk8FbMM=";
        };
        file = "forgit.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "aaafebcd97424c570ee247e2aeb3da30444299cd";
          sha256 = "sha256-9Wr4uZLk2CvINJilg4o72x0NEAl043lP30D3YnHk+ZA=";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "2d89ef1d06f76997790b45df5ac447f0c3ffd34c";
          sha256 = "sha256-KO1z5/9vRh4JNNawbUhy9Zgr3ywGfpSEMx/4N0V+vmw=";
        };
        file = "pure.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "caa749d030d22168445c4cb97befd406d2828db0";
          sha256 = "sha256-YV9lpJ0X2vN9uIdroDWEize+cp9HoKegS3sZiSpNk50=";
        };
        file = "zsh-syntax-highlighting.plugin.zsh";
      }
    ];
  };
}
