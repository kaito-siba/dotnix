{ pkgs, ... }:
let
  # MiMo-Code (https://github.com/XiaomiMiMo/MiMo-Code)
  # 本体は GitHub Releases で配布される bun製コンパイル済み単一実行ファイル。
  # npmの @mimo-ai/cli / プラットフォームパッケージは bun ランタイム単体で
  # アプリ本体を含まないため、Releases のバイナリを直接取得する。
  #
  # bun standalone は埋め込みアプリを実行ファイル末尾のトレーラから読むため、
  # patchelf で rpath を書き換えたり strip するとトレーラが壊れて
  # ただの bun ランタイムに戻ってしまう(autoPatchelfHook は使えない)。
  # 必要な共有ライブラリは glibc のみ(libc/pthread/dl/m)なので、
  # インタプリタだけを差し替える(nixのglibc ldが自身のlibcを解決する)。
  # linux-x64(非baseline)は AVX2 必須。このホストはAVX2対応。
  version = "0.1.1";
  mimocode = pkgs.stdenv.mkDerivation {
    pname = "mimocode";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/XiaomiMiMo/MiMo-Code/releases/download/v${version}/mimocode-linux-x64.tar.gz";
      hash = "sha256-U6d3xNgo1WShOaUFaevvBxzShrF5oTpfzcI4V84lb3o=";
    };

    sourceRoot = ".";

    nativeBuildInputs = [ pkgs.patchelf ];

    # bunトレーラ破壊を避けるため自動patchelf/stripを無効化
    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 mimo $out/bin/mimo
      patchelf --set-interpreter \
        "$(cat ${pkgs.stdenv.cc}/nix-support/dynamic-linker)" \
        $out/bin/mimo
      runHook postInstall
    '';

    meta = {
      description = "MiMo Code: terminal-native AI coding assistant by Xiaomi MiMo";
      homepage = "https://github.com/XiaomiMiMo/MiMo-Code";
      license = pkgs.lib.licenses.mit;
      mainProgram = "mimo";
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  home.packages = [ mimocode ];
}
