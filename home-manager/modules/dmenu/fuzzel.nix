{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = "\"can I have \"";
        use-bold = "yes";
        width = 140;
        lines = 20;
        vertical-pad = 16;
        horizontal-pad = 16;
      };

      border.width = 2;
      border.radius = 10;
    };
  };
}
