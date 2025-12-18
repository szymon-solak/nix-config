{
  programs.git = {
    enable = true;

    # difftastic = {
    #   enable = true;
    #   color = "always";
    #   display = "inline";
    # };

    settings = {
      alias = {
        unstage = "reset HEAD --";
        cp = "cherry-pick";
      };

      user = {
        name = "Szymon Solak";
        email = "16944591+szymon-solak@users.noreply.github.com";
      };

      rerere = {enabled = 1;};
      commit = {template = "${./gitmessage}";};
      init = {defaultBranch = "main";};
    };
  };
}
