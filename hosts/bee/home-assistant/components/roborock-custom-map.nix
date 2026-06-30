{
  fetchFromGitHub,
  buildHomeAssistantComponent,
}:
buildHomeAssistantComponent rec {
  owner = "Lash-L";
  domain = "roborock_custom_map";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "Lash-L";
    repo = "RoborockCustomMap";
    tag = "${version}";
    hash = "sha256-jXkKjjof1/JeT0KDKIC4sX+P7JwWOzajbFOhlq772L8=";
  };
}
