{ pkgs, ... }:let
  arcwtf = pkgs.fetchFromGitHub {
    owner = "KiKaraage";
    repo = "ArcWTF";
    rev = "d2edf1a830c22144dca2714ec48e810e9e728716";
    hash = "sha256-M4VBx7itLuqX6AKVC1/KKiRfrBob5eXtQZP53uveiMc=";
  };
  profile = "default";
in {
  home.packages = with pkgs; [
    firefox-wayland
    libva
    libva-utils
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
    ];
    profiles.${profile} = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "uc.tweak.popup-search" = true;
        "uc.tweak.hide-sidebar-header" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "services.sync.prefs.sync.browser.toolbars.bookmarks.visibility" = true;
      };
      # extensions = {
      #   packages = with pkgs.nur.repos.rycee.firefox-addons; [
      #     ublock-origin
      #   ];
      #   settings = {
      #     "uBlock0@raymondhill.net".settings = {
      #       selectedFilterLists = [
      #         "ublock-filters"
      #         "ublock-badware"
      #         "ublock-privacy"
      #         "ublock-unbreak"
      #         "ublock-quick-fixes"
      #       ];
      #     };
      #   };
      # };
    };
  };

  systemd.user.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  home.file = {
    ".mozilla/firefox/${profile}/chrome" = {
      source = arcwtf;
      recursive = true;
    };
    ".config/tridactyl" = {
      source = ./tridactyl;
      recursive = true;
    };
  };
}
