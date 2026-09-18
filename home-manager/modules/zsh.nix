{
  pkgs,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autocd = true;

    completionInit = ''
      autoload -Uz compinit
      if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
        compinit -C
      else
        compinit
      fi
      		'';

    autosuggestion = {
      enable = true;
      highlight = "fg=244";
    };

    syntaxHighlighting = {
      enable = true;
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

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      path = "${config.xdg.dataHome}/.zsh/history";
      share = false;
      size = 100000;
      save = 100000;
    };

    sessionVariables = {
      COLORTERM = "truecolor";
      TERM = "xterm-256color";
      EDITOR = "vi";
    };

    initContent = ''
       if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
       	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
       	. /nix/var/nix/profiles/default/etc/profile.d/nix.sh
       fi

           export PATH=$PATH:$HOME/bin:/usr/local/bin
           export PATH=$PATH:$HOME/.local/bin
           export SSH_ASKPASS_REQUIRE=prefer
      export TMPDIR=/tmp

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
          rev = "15db0016623b87472c0b6ff7488b123a74b82c7e";
          sha256 = "sha256-VJiUXbArwe0oTQVznDMgPEIhzqvFZI7ciezbNuWH620=";
        };
        file = "forgit.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "acd0e1984df350c189f8f9c4956ec586b6c73fca";
          sha256 = "sha256-/SReaADtuE6f3rT/eLh2vI4ucEFpWpDLz+TdbZxYjjc=";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "89c9e30a38d3d35457bcc58b43ea6c28ae56934b";
          sha256 = "sha256-ZNi0ruTX9HRELXq1yvTm+StOuQ0UZgK6toMSgwqSD9A=";
        };
        file = "pure.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "24105b15714bfec37989ed5c5b6e60f572253019";
          sha256 = "sha256-YhTSu0P7mFlVx1zBvbT0jNstkamcZHhPYJHKMAHgyuM=";
        };
        file = "fzf-tab.plugin.zsh";
      }
    ];
  };

  programs.fzf.enableZshIntegration = true;
}
