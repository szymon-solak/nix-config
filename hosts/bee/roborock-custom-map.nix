{
  fetchFromGitHub,
  buildHomeAssistantComponent,
}:
buildHomeAssistantComponent rec {
  owner = "Lash-L";
  domain = "roborock_custom_map";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "Lash-L";
    repo = "RoborockCustomMap";
    tag = "${version}";
    hash = "sha256-ZKaUTUTN0tTW8bks0TYixfmbEa7A7ERdJ+xZ365HEbU=";
  };
}
