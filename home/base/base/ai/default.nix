{ pkgs, claude-code, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.117.0";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-n3icJBOFQx8f6czScRMhHxz9hGVfFVpcBiAQtixvWi8=";
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
    version = "0.33.0";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-iZkX9pXfdRuxfCNbxL+/IKow3pd1lYrKQddcknS2sSg=";
    };

    npmDepsHash = "sha256-LPgTjxsavkrgraLAivkwwrRlTSltYekqbFCyXf8eSE0=";

    postPatch = ''
      cp ${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/nrslib/takt/v${version}/package-lock.json";
          hash = "sha256-lYvwBX1f0znIvrkKuS0IT8kqOWTaoTWuO4cmOc/DjDg=";
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
