{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;

    shellAliases = {
      ip = "ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\\  -f2";
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

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi
    '';

    initExtra = ''
            export PATH=$PATH:$HOME/bin:/usr/local/bin
            export PATH=$PATH:$HOME/.local/bin

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
          rev = "17394d10569899eded337dec59ef461f8becea51";
          sha256 = "odxdySx3Bzxs5RMXJ4nivwltQYIaM/UrPb+A0/pnDSk=";
        };
        file = "forgit.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "afaf2965b41fdc6ca66066e09382726aa0b6aa04";
          sha256 = "FnGjp/VJLPR6FaODY0GtCwcsTYA4d6D8a6dMmNpXQ+g=";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "da1a722238febb9a4b97c77628fae753d1817490";
          sha256 = "Hdb5wGVkNrmmVWZaKf3xUnNYsTX/8Bb7AhgLNJxNAUc=";
        };
        file = "pure.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
          sha256 = "4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
        };
        file = "zsh-syntax-highlighting.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c7fb028ec0bbc1056c51508602dbd61b0f475ac3";
          sha256 = "Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
        file = "fzf-tab.plugin.zsh";
      }
    ];
  };

  programs.fzf.enableZshIntegration = true;
}
