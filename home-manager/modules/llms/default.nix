{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;

    context = ./context.md;

    skills = {
      caveman = ./skills/caveman;
      grill-me = ./skills/grill-me;
      grilling = ./skills/grilling;
      code-review = ./skills/code-review;
      handoff = ./skills/handoff;
    };

    settings = {
      allow = [
        "Bash(git diff:*)"
      ];
      deny = [
        "WebFetch"
        "Bash(curl:*)"
        "Read(./.env)"
        "Read(./secrets/**)"
      ];
      includeCoAuthoredBy = false;
      disableBypassPermissionsMode = "disable";
      theme = "dark";
    };
  };

  home.packages = [
    pkgs.jq
  ];
}
