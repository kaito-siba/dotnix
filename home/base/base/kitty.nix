{ ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
        name = "Guguru Sans Code 35";
    };
    shellIntegration.enableZshIntegration = true;
  };
}
  
