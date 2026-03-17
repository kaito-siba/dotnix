{ pkgs, claude-code, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.114.0";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-kinejFHI7zBWW7UHyXou3ASoCzjkmkNj8zf+Bb7fNOs=";
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
    version = "0.32.1";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-wA08cdwQq08l9CL0JzXYzYHLvq3WyhYMNK112lWxClA=";
    };

    npmDepsHash = "sha256-3uyaIvfl0LOZBoVnzih9UVAkTFGeWNPAqfaTOSNYqI4=";

    postPatch = ''
      cp ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nrslib/takt/v${version}/package-lock.json";
        hash = "sha256-VmgPIpUI8Wvj7Q+CeLrIcFrCu+fW31eh+PgrpeNK8pA=";
      }} package-lock.json
    '';

    dontNpmBuild = true;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postInstall = ''
      wrapProgram $out/bin/takt \
        --prefix PATH : ${pkgs.lib.makeBinPath [
          pkgs.nodejs_20
          pkgs.bash
          pkgs.git
          pkgs.gh
        ]}
    '';
  };
in
{
  home.packages = [
    codex-rs
    claude-code.packages.${pkgs.system}.default
    takt
  ];

  home.file = {
    ".codex/" = {
      source = ./codex;
      recursive = true;
    };
  };
}
