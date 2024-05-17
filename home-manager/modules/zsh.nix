{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;

    shellAliases = {
      ip = "ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\\  -f2";
      ls = "eza -lah --sort=type --icons";

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
    '';

    plugins = with pkgs; [
      {
        name = "forgit";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "f1ac9e3f7f1cfb5eb7cea02bfcaa56eb25ddbcbc";
          sha256 = "sha256-/hnofpzfhgSrJyzMWgk0DLIhIWEl9juVBuxwztwF8Yo=";
        };
        file = "forgit.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "dc9e2bc0cdbaa0a507371c248d3dcc9f58db8726";
          sha256 = "sha256-T0iZK9Tb7ExJaZ6e2UmwecnKHMQilwAPkyAa/uhqrw0=";
        };
        file = "zsh-z.plugin.zsh";
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "87e6f5dd4c793f6d980532205aaefe196780606f";
          sha256 = "sha256-TR4CyBZ+KoZRs9XDmWE5lJuUXXU1J8E2Z63nt+FS+5w=";
        };
        file = "pure.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "1386f1213eb0b0589d73cd3cf7c56e6a972a9bfd";
          sha256 = "sha256-iKx7lsQCoSAbpANYFkNVCZlTFdwOEI34rx/h1rnraSg=";
        };
        file = "zsh-syntax-highlighting.plugin.zsh";
      }
    ];
  };

  programs.fzf.enableZshIntegration = true;
}
