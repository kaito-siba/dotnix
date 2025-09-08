{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix.url = "github:yaxitech/ragenix";
    mysecrets = {
      url = "github:kaito-siba/nix-secrets";
      flake = false;
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      type = "github";
      owner = "abenz1267";
      repo = "walker";
      ref = "v1.0.0-beta-26";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #TODO use nightly
    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = 
    { 
      self, 
      nixpkgs, 
      nixpkgs-unstable, 
      home-manager, 
      ragenix,
      mysecrets,
      zen-browser,
      walker,
      ... 
    }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

     forAllSystems = nixpkgs.lib.genAttrs systems;

     mkModules =
       {
          host,
          system,
          user ? "w963n",
       }:
       let # substritute "x86_64-linux" => "linux"
         os = builtins.elemAt (builtins.match ".*-(.*)" system) 0;
         specialArgs = {
           pkgs-unstable = import nixpkgs-unstable {
             inherit system;
             config.allowUnfreePredicate =
               pkg:
               builtins.elem (nixpkgs.lib.getName pkg) [
                 "slack"
                 "vscode"
                 "discord"
               ];
           };
           inherit zen-browser walker;
        };
      in
      [
        ./hosts/${host}
        ragenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users = import ./hosts/${host}/home.nix;
        }
      ];
    in
    {
      nixosConfigurations = 
        builtins.mapAttrs
          (
            host: system:
              nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit ragenix mysecrets;
                };
                modules = mkModules { inherit system host; };
              }
          )
          {
            siba-ultimate-pc = "x86_64-linux";
            radiata = "x86_64-linux";
          };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };

    nixConfig = {
      experimental-features = [
        "nix-command"
       	"flakes"
      ];

      auto-optimise-store = true;
    };
}
