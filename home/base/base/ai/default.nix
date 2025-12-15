{ pkgs, ... }:
let
  codex-rs = pkgs.stdenv.mkDerivation rec {
    pname = "codex";
    version = "0.72.0";

    src = pkgs.fetchurl {
      url =
        "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "sha256-Qi4D9aXMGjuHc0qlfp1CUBwzRHld9L4t3fmf8f/95xw=";
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
