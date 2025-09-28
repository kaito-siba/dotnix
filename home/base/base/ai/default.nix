{ pkgs, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.42.0";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-OK1323WqBfbrYN3UPqP9e5oe8VoTfwLji1Gak6WZAIQ=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src -C $out/bin
      mv $out/bin/codex-x86_64-unknown-linux-musl $out/bin/codex
      chmod +x $out/bin/codex
    '';
  };
in {
  home.packages = [ codex-rs ];

  home.file = {
    ".codex/" = {
      source = ./codex;
      recursive = true;
    };
  };
}
