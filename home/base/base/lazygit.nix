{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta --paging=never --width=120 --max-line-length=2000 --max-syntax-highlighting-length=200";
          }
        ];
      };
    };
  };
}
