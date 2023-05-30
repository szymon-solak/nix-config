{
  programs.git = {
    enable = true;
    aliases = {
      unstage = "reset HEAD --";
      cp = "cherry-pick";
    };
    extraConfig = {
      rerere = { enabled = 1; };
      commit = { template = "${./.gitmessage}"; };
    };
  };
}
