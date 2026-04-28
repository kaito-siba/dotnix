{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    elephant = { url = "github:abenz1267/elephant"; };

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    opencode = {
      url = "github:sst/opencode";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    claude-code = {
      url = "github:sadjow/claude-code-nix?ref=latest";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sqlit = {
      url = "github:Maxteabag/sqlit";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #TODO use nightly
    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ragenix, mysecrets
    , zen-browser, walker, ghostty, opencode, claude-code, sqlit, noctalia, niri, xremap, ... }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkModules = { host, system, user ? "w963n", }:
        let # substritute "x86_64-linux" => "linux"
          os = builtins.elemAt (builtins.match ".*-(.*)" system) 0;
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfreePredicate = pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "slack"
                  "vscode"
                  "discord"
                  "obsidian"
                  "cuda_cudart"
                  "cuda_nvcc"
                  "cuda_cccl"
                  "libcublas"
                  "google-chrome"
                ];
            };
            inherit zen-browser walker ghostty opencode claude-code sqlit noctalia mysecrets ragenix xremap;
          };
        in [
          ./hosts/${host}
          ragenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ (import ./overlays/activitywatch.nix) ];

            nix.settings = {
              substituters = [ "https://claude-code.cachix.org" ];
              trusted-public-keys = [
                "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
              ];
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users = import ./hosts/${host}/home.nix;
          }
        ];
    in {
      nixosConfigurations = builtins.mapAttrs (host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit ragenix mysecrets niri xremap; };
          modules = mkModules { inherit system host; };
        }) {
          siba-ultimate-pc = "x86_64-linux";
          radiata = "x86_64-linux";
          corebook = "x86_64-linux";
        };

      homeConfigurations."k-nanchi@mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          overlays = [ (import ./overlays/activitywatch.nix) ];
        };
        modules = [ ./home/darwin ];
      };

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    auto-optimise-store = true;
  };
}
