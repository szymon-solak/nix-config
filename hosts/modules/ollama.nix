{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    loadModels = ["mistral:7b" "granite-code:3b" "granite-code:8b"];
  };

  services.open-webui = {
    enable = true;
    port = 11111;
  };
}
