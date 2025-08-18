{ pkgs, ... }:let
  nodePkgs = pkgs.callPackage ./packages { inherit pkgs; };
in 
{
  home.packages = [
    nodePkgs."yii2-mcp-server"
  ];
}
