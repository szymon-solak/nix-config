{
  programs.git = {
    enable = true;

		difftastic = {
			enable = true;
			color = "always";
			display = "inline";
		};

		userName = "Szymon Solak";
		userEmail = "16944591+szymon-solak@users.noreply.github.com";

    aliases = {
      unstage = "reset HEAD --";
      cp = "cherry-pick";
    };

    extraConfig = {
      rerere = { enabled = 1; };
      commit = { template = "${./.gitmessage}"; };
			init = { defaultBranch = "main"; };
    };
  };
}
