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
    version = "0.33.2";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-/Kpi9VMLVu/I2rs2SVgE/aeKdj88Fd+kYXfIAGQq3+8=";
    };

    npmDepsHash = "sha256-+m06xCFlS6zgY2QzR6OduwVW3MAvAyHG1/qsMDUzqtU=";

    postPatch = ''
      cp ${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/nrslib/takt/v${version}/package-lock.json";
          hash = "sha256-v4LUqgQPFfUkoIRQYqVUS/OKpxpQnyjp/byi4gpUxjk=";
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
