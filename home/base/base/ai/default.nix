{ pkgs, claude-code, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.118.0";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-5wfqZde7vEagSv5zG/PBSlt3UiEAzr+LuTz/uVz0YQs=";
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
    version = "0.35.0";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-E8sW27JcKpCDWwjpW6bKcgK9w6WzEdZK+mDTMKde+4g=";
    };

    npmDepsHash = "sha256-IE3Xjmtdtgi+v7w5+KOhd8uyVkmX9efEY9mNiaSU4aY=";

    postPatch = ''
      cp ${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/nrslib/takt/v${version}/package-lock.json";
          hash = "sha256-ktOWkmxf1lX7n2WkbIe82GLVWJjZOX2hNNnj300wGyM=";
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
