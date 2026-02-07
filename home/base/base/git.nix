{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "k-nanchi";
        email = "kaito@siba-service.jp";
      };
      include = {
        path = "~/.config/delta/delta.gitconfig";
      };
    };
    lfs.enable = true;
    ignores = [
      ".envrc"
      ".direnv/"
    ];
  }; 

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
