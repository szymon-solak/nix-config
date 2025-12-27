{pkgs, ...}: {
  programs.claude-code = {
    enable = true;
    memory.text = ''
      - In all interactions, be extremaly concise and sacrifice grammer for the sake of concision.

      ## Plans

      - At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremaly concise. Sacrifice grammar for the sake of concision.
    '';
    settings = {
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
    pkgs.opencode
  ];
}
