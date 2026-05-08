{ pkgs, claude-code, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.129.0";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-Skoo0i3R+HTix7I9m6E9sCv3rU7ppwucTqq2GHCNBYI=";
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
            pkgs.nodejs_20
            pkgs.bash
            pkgs.git
            pkgs.gh
          ]
        }
    '';
  };
in
{
  home.packages = [
    codex-rs
    claude-code.packages.${pkgs.system}.default
    takt
    pkgs.bubblewrap # for sandboxing codex
  ];

  home.file = {
    ".codex/" = {
      source = ./codex;
      recursive = true;
    };
  };
}
