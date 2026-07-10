{ pkgs, claude-code, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.144.1";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-hAka4gxl/MfUEg25fRvVfX/435x2Cft4HHjC671PWig=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src -C $out/bin
      mv $out/bin/codex-x86_64-unknown-linux-musl $out/bin/codex
      chmod +x $out/bin/codex
    '';
  };
  takt = pkgs.buildNpmPackage rec {
    pname = "takt";
    version = "0.37.0";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-+US/mVNgNz3SApmD/OZxJnXwHpF35rqiQ1HlgSXylfo=";
    };

    npmDepsHash = "sha256-YESxSZvQDr7PGcsYN0+kv/Gy3G71G8eXrGGPVKsV7R8=";

    postPatch = ''
      cp ${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/nrslib/takt/v${version}/package-lock.json";
          hash = "sha256-rndzyz957AQy+W297V2rvG4y5chpvot9T+wISFkGB7A=";
        }
      } package-lock.json
    '';

    dontNpmBuild = true;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postInstall = ''
      wrapProgram $out/bin/takt \
        --prefix PATH : ${
          pkgs.lib.makeBinPath [
            pkgs.nodejs_24
            pkgs.bash
            pkgs.git
            pkgs.gh
          ]
        }
    '';
  };
  search-sessions = pkgs.rustPlatform.buildRustPackage {
    pname = "search-sessions";
    version = "0.3.1";

    src = pkgs.fetchFromGitHub {
      owner = "sinzin91";
      repo = "search-sessions";
      rev = "v0.3.1";
      hash = "sha256-Svsi3KrkO/zHhoSHdTNNmF7Lse8nd96d6ZLABto3wSA=";
    };

    cargoHash = "sha256-rXl6aESEKjc4v+Onmvcj9gVEAzVBVYfaOFsY1Yvnofc=";

    # Integration tests require real session files under $HOME (unavailable in sandbox).
    doCheck = false;
  };
in
{
  imports = [ ./mimocode.nix ];

  home.packages = [
    codex-rs
    claude-code.packages.${pkgs.system}.default
    takt
    search-sessions
    pkgs.bubblewrap # for sandboxing codex
  ];

  home.file = {
    ".codex/" = {
      source = ./codex;
      recursive = true;
    };
  };
}
