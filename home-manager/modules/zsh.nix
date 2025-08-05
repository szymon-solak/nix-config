{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;

    autosuggestion = {
      enable = true;
      highlight = "fg=244";
    };

    shellAliases = {
      # ip = "ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\\  -f2";
      ls = "eza -lah --sort=type --icons=auto";
      uuid = "uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy";

      # Git
      gst = "git status";
      gc = "git commit -v";
      gwl = "git worktree list";
      gwa = "git worktree add";
      gwc = "git worktree add -b";
      gwd = "git worktree remove";
    };

    history.size = 25000;
    history.path = "${config.xdg.dataHome}/.zsh/history";

    initContent = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
      	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      	. /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

          export PATH=$PATH:$HOME/bin:/usr/local/bin
          export PATH=$PATH:$HOME/.local/bin
          export SSH_ASKPASS_REQUIRE=prefer

      if [ -n "''${commands[fzf-share]}" ]; then
      	source "$(fzf-share)/key-bindings.zsh"
      	source "$(fzf-share)/completion.zsh"
      fi

          if [ -z "$SSH_AUTH_SOCK" ]; then
          	eval `ssh-agent -s`
          fi
    '';

    plugins = with pkgs; [
      {
        name = "forgit";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "755b3dd9f85c044a3bd76059b24b1ad63d5c0617";
          sha256 = "sha256-tZFGQirm7dCHXGrnAB5qynVzWEMKnV/6Kfmja/3Os20=";
        };
        file = "forgit.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "dd94ef04acc41748ba171eb219971cb455e0040b";
          sha256 = "sha256-CJjPjXIHUpEcKoExyskVeJGWXAjr2Pix3Uszuy/veGc=";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "92b8e9057988566b37ff695e70e2e9bbeb7196c8";
          sha256 = "sha256-TbOrnhLHgOvcfsgmL0l3bWY33yLIhG1KSi4ITIPq1+A=";
        };
        file = "pure.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "5eb677bb0fa9a3e60f0eff031dc13926e093df92";
          sha256 = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
        };
        file = "zsh-syntax-highlighting.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "6aced3f35def61c5edf9d790e945e8bb4fe7b305";
          sha256 = "sha256-EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
        };
        file = "fzf-tab.plugin.zsh";
      }
    ];
  };

  programs.fzf.enableZshIntegration = true;
}
