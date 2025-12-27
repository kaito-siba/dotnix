{ pkgs, pkgs-unstable, ... }:
{
  services.ollama={
    enable = true; 
    acceleration = "cuda"; 
    package = pkgs-unstable.ollama.override { 
      acceleration = "cuda"; 
    }; 
  }; 

  home.file.".ollama/modelfiles" = {
    source = ./modelfiles;
    recursive = true;
  };
}
