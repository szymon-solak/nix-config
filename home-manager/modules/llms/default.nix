{pkgs, ...}: {
  programs.claude-code = {
    enable = true;

    context = ./context.md;

    skills = {
      caveman = ./skills/caveman;
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

      hooks = {
        PreToolUse = [
          {
            matcher = "Bash";
            hooks = [
              {
                type = "command";
                command = ./rtk-rewrite.sh;
              }
            ];
          }
        ];
      };
    };
  };

  home.packages = [
    pkgs.opencode
    pkgs.rtk
    pkgs.jq
  ];
}
