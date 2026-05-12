{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            colorArg = "always";
            externalDiffCommand = "difft --color=always --display=inline --syntax-highlight=on --tab-width=2";
          }
        ];
      };
    };
  };
}
