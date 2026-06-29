{ pkgs, zen-browser, ... }:
{
  imports = [ 
    zen-browser.homeModules.twilight
  ];

  # home.packages = [
  #   zenBrowser.packages.${pkgs.system}.twilight
  # ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.tridactyl-native ];

    # MozillaのGFXブロックリスト(gfx.blacklist.dmabuf / gl.threadsafe)を
    # 上書きし、HWアクセラレーション(WebRender/VA-API)を強制有効化する
    policies.Preferences = {
      "widget.dmabuf.force-enabled" = { Value = true; Status = "locked"; };
      "gfx.webrender.all" = { Value = true; Status = "locked"; };
      "media.ffmpeg.vaapi.enabled" = { Value = true; Status = "locked"; };
      "media.hardware-video-decoding.force-enabled" = { Value = true; Status = "locked"; };
      # 注: WebGLのゼロコピー(DMABUF_WEBGL)はNVIDIAバイナリドライバで
      # Firefox組み込みブロック(bug 1924578: canvas描画破損)のため有効化不可。
      # Google Earth等の重いWebGLはChromium系の方が速い(Firefox側のNVIDIA制約)。
    };
  };
}
