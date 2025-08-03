{ ... }:
{
  "files.autoSave" = "off";
  # ===== General =====
  "editor.wordSeparators" = "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?　、。「」【】『』（）！？てにをはがのともへでや";
  "git.confirmSync" = false;
  "editor.fontSize" = 14;
  "editor.fontFamily" = "'UDEV Gothic 35JPDOC', 'HackGenNerd Console'";
  "editor.tabSize" = 2;
  "editor.renderWhitespace" = "all";
  "workbench.iconTheme" = "catppuccin-latte";
  "icontheme.lightIconTheme" = "catppuccin-latte";
  "icontheme.darkIconTheme" = "catppuccin-mocha";
  "editor.minimap.enabled" = false;
  "terminal.integrated.inheritEnv" = false;
  "terminal.integrated.fontFamily" = "MesloLGS Nerd Font Mono";
  "terminal.integrated.fontSize" = 14;
  "terminal.integrated.scrollback" = 999999;
  "git.autofetch" = true;
  "editor.suggestSelection" = "first";
  "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
  "json.schemas" = [];
  "editor.unicodeHighlight.allowedCharacters" = {
    "　" = true;
  };
  "files.trimTrailingWhitespace" = true;
  "diffEditor.ignoreTrimWhitespace" = true;
  "gitlens.views.commitDetails.files.layout" = "tree";
  "editor.guides.bracketPairs" = true;
  "workbench.preferredLightColorTheme" = "Catppuccin Latte";
  "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
  "editor.formatOnSave" = true;
  "editor.codeActionsOnSave" = {
    "source.fixAll" = "explicit";
  };
  "window.commandCenter" = false;
  "editor.accessibilitySupport" = "off";
  "editor.unicodeHighlight.ambiguousCharacters" = false;
  "editor.defaultFormatter" = "esbenp.prettier-vscode";
  "window.autoDetectColorScheme" = true;

  # ===== Mac =====
  "terminal.external.osxExec" = "Warp.app";

  # ===== Windows =====
  "explorer.confirmDelete" = false;
  "terminal.integrated.profiles.windows" = {
    "GitBash" = {
      "path" = ["C:\\Users\rkv_r\\scoop\\apps\\git\\current\\git-bash.exe"];
      "icon" = "terminal-bash";
      "args" = ["-l"];
    };
  };
  "terminal.integrated.defaultProfile.windows" = "GitBash";

  # ===== cSpell =====
  "cSpell.userWords" = [
    "BSON"
    "Doshisha"
    "ellipsize"
    "gradio"
    "Medicaroid"
    "NOTEARS"
    "positionals"
    "Swiper"
    "tanstack"
    "toastify"
    "Todos"
    "typeorm"
  ];

  # ===== Jupyter Notebook =====
  "workbench.editorAssociations" = {
    "*.out" = "default";
    "*.ipynb" = "jupyter-notebook";
    "*.pdf" = "latex-workshop-pdf-hook";
  };
  "notebook.cellToolbarLocation" = {
    "default" = "right";
    "jupyter-notebook" = "left";
  };

  # ===== LiveServer =====
  "liveServer.settings.donotShowInfoMsg" = true;

  # ===== ESLint =====
  "eslint.validate" = [
    "javascript"
    "typescriptreact"
    "javascript"
    "typescriptreact"
  ];

  # ===== Markdown =====
  "markdown-preview-enhanced.hideDefaultVSCodeMarkdownPreviewButtons" = false;

  # ===== React =====
  "reactSnippets.settings.importReactOnTop" = false;
  "reactSnippets.settings.typescriptPropsStatePrefix" = "interface";

  # ===== Python =====
  "[python]" = {
    "editor.formatOnSave" = true;
    "editor.defaultFormatter" = "ms-python.black-formatter";
  };

  # ===== Draw.io =====
  "hediet.vscode-drawio.resizeImages" = null;

  # ===== Project Manager =====
  "projectManager.tags" = ["Personal" "Work" "Univ"];

  # ===== PHP =====
  "intelephense.environment.phpVersion" = "8.2.7";

  # ===== SQL =====
  "[sql]" = {
    "editor.defaultFormatter" = "adpyke.vscode-sql-formatter";
  };

  # ===== Remote SSH =====
  "remote.autoForwardPortsSource" = "hybrid";

  "window.zoomLevel" = 0.1;
  "cursor.cpp.disabledLanguages" = ["plaintext" "markdown" "scminput"];
  "[php]" = {
    "editor.defaultFormatter" = "bmewburn.vscode-intelephense-client";
  };
  "[json]" = {
    "editor.defaultFormatter" = "vscode.json-language-features";
  };
  "workbench.tree.enableStickyScroll" = true;
  "svg.preview.mode" = "svg";
  "files.autoGuessEncoding" = true;
  "git.suggestSmartCommit" = false;
  "extensions.experimental.affinity" = {
    "asvetliakov.vscode-neovim" = 1;
  };
  "prettier.useEditorConfig" = false;
  "githubPullRequests.pullBranch" = "never";
  "diffEditor.renderSideBySide" = false;

  # vim
  # 行を折り返しする(マウスを使わないため)
  "editor.wordWrap" = "on";
  # sync os clipboard
  "vim.useSystemClipboard" = true;
  "vim.leader" = "<space>";
  "vim.easymotion" = true;
  "vim.incsearch" = true;
  "vim.useCtrlKeys" = true;
  "vim.hlsearch" = true;
  "vim.surround" = true;
  # c-p vdcode file検索を優先
  # c-f vdcode grepを優先(ctrl+fをgrepにしているため)
  "vim.handleKeys" = {
    "<C-p>" = false;
    "<C-f>" = false;
  };
  "vim.normalModeKeyBindings" = [];
  "vim.normalModeKeyBindingsNonRecursive" = [
    # ctrl + jkhl で window focus移動
    {
      "before" = ["<C-h>"];
      "after" = ["<C-w>" "h"];
    }
    {
      "before" = ["<C-j>"];
      "after" = ["<C-w>" "j"];
    }
    {
      "before" = ["<C-k>"];
      "after" = ["<C-w>" "k"];
    }
    {
      "before" = ["<C-l>"];
      "after" = ["<C-w>" "l"];
    }
    # shift + HL(左右) で buffer(file) 移動
    {
      "before" = ["H"];
      "after" = ["g" "T"];
    }
    {
      "before" = ["L"];
      "after" = ["g" "t"];
    }
    # vscode undo redoにvim undo redoをbind
    {
      "before" = ["u"];
      "commands" = ["undo"];
    }
    {
      "before" = ["<C-r>"];
      "commands" = ["redo"];
    }
    {
      "before" = ["<C-n>"];
      "after" = ["g" "b"];
    }
    {
      "before" = ["<CR>"];
      "commands" = ["editor.action.smartSelect.expand"];
    }
    {
      "before" = ["<S-CR>"];
      "commands" = ["editor.action.smartSelect.shrink"];
    }
    {
      "before" = ["<Leader>" "c"];
      "commands" = [{ "command" = "editor.action.commentLine"; }];
    }
    # 削除時にyankさせない
    {
      "before" = ["x"];
      "after" = ["\"" "_" "x"];
    }
    {
      "before" = ["s"];
      "commands" = [{ "command" = "lumpat.jumpMulti"; }];
    }
    {
      "before" = ["<leader>" "x"];
      "commands" = [{ "command" = "editor.action.codeAction"; }];
    }
    {
      "before" = ["<leader>" "d"];
      "commands" = [{ "command" = "workbench.actions.view.toggleProblems"; }];
    }
    # ファイルツリーへの移動
    {
      "before" = ["<Leader>" "o"];
      "commands" = ["workbench.action.focusSideBar"];
    }
    # ファイルツリーの開閉
    {
      "before" = ["<Leader>" "e"];
      "commands" = ["workbench.action.toggleSidebarVisibility"];
      "when" = ["editorFocus && vim.mode == 'Normal'"];
    }
    # ファイル検索
    {
      "before" = ["<Leader>" "f" "f"];
      "commands" = ["multiCommand.findFiles"];
      "when" = ["editorFocus && vim.mode == 'Normal'"];
    }
    # 全体検索
    {
      "before" = ["<Leader>" "f" "g"];
      "commands" = ["multiCommand.findWithinFiles"];
      "when" = ["editorFocus && vim.mode == 'Normal'"];
    }
    # git
    {
      "before" = ["<Leader>" "g" "l"];
      "commands" = ["gitlens.showQuickFileHistory"];
      "when" = ["editorFocus && vim.mode == 'Normal'"];
    }
    {
      "before" = ["<Leader>" "g" "g"];
      "commands" = ["lazygit-vscode.toggle"];
      "when" = [
        "editorFocus && !editorTextFocus && vim.mode == 'Normal'"
        "workbench.action.focusActiveEditorGroup"
      ];
    }
    # split
    {
      "before" = ["<Leader>" "s"];
      "commands" = ["workbench.action.splitEditorRight"];
    }
    {
      "before" = ["<Leader>" "v"];
      "commands" = ["workbench.action.splitEditorDown"];
    }
  ];
  # jk で insertを抜ける jjは邪道
  "vim.insertModeKeyBindings" = [
    {
      "before" = ["j" "k"];
      "after" = ["<Esc>"];
    }
  ];
  "vim.visualModeKeyBindingsNonRecursive" = [
    {
      "before" = ["p"];
      "after" = ["\"" "_" "d" "P"];
    }
    {
      "before" = ["<C-n>"];
      "after" = ["g" "b"];
    }
    {
      "before" = ["<CR>"];
      "commands" = ["editor.action.smartSelect.expand"];
    }
    {
      "before" = ["<S-CR>"];
      "commands" = ["editor.action.smartSelect.shrink"];
    }
    {
      "before" = ["<Leader>" "c"];
      "commands" = [{ "command" = "editor.action.commentLine"; }];
    }
    # 削除時にyankさせない
    {
      "before" = ["x"];
      "after" = ["\"" "_" "x"];
    }
    {
      "before" = ["s"];
      "after" = ["\"" "_" "s"];
    }
    {
      "before" = ["<C-a>"];
      "commands" = [{ "command" = "incrementor.incrementByOne"; }];
    }
    {
      "before" = ["<C-x>"];
      "commands" = [{ "command" = "incrementor.decrementByOne"; }];
    }
    # toggle terminal
    {
      "before" = ["<Leader>" "t"];
      "commands" = [{ "command" = "workbench.action.terminal.toggleTerminal"; }];
    }
  ];
  # minimarp 非表示(スプリットしたとき邪魔)
  "editor.minimap.renderCharacters" = false;
  # relative number表示
  "editor.lineNumbers" = "relative";
  "window.titleBarStyle" = "custom";
  # scrollbar非表示（マウス使わないため）
  "editor.scrollbar.vertical" = "hidden";
  "editor.scrollbar.horizontal" = "hidden";
  "workbench.editor.enablePreview" = false;
  "workbench.editor.editorActionsLocation" = "hidden";
  "workbench.editor.wrapTabs" = true;
  "search.mode" = "reuseEditor";
  "workbench.statusBar.visible" = true;
  "workbench.layoutControl.enabled" = false;
  "terminal.integrated.defaultProfile.linux" = "zsh";
  "terminal.integrated.defaultProfile.osx" = "zsh";
  "terminal.integrated.shellIntegration.enabled" = false;
  "cursor.cmdk.useThemedDiffBackground" = false;
  "intelephense.stubs" = [
    "apache"
    "bcmath"
    "bz2"
    "calendar"
    "com_dotnet"
    "Core"
    "ctype"
    "curl"
    "date"
    "dba"
    "dom"
    "enchant"
    "exif"
    "FFI"
    "fileinfo"
    "filter"
    "fpm"
    "ftp"
    "gd"
    "gettext"
    "gmp"
    "hash"
    "iconv"
    "imap"
    "intl"
    "json"
    "ldap"
    "libxml"
    "mbstring"
    "meta"
    "mysqli"
    "oci8"
    "odbc"
    "openssl"
    "pcntl"
    "pcre"
    "PDO"
    "pgsql"
    "Phar"
    "posix"
    "pspell"
    "random"
    "readline"
    "Reflection"
    "session"
    "shmop"
    "SimpleXML"
    "snmp"
    "soap"
    "sockets"
    "sodium"
    "SPL"
    "sqlite3"
    "standard"
    "superglobals"
    "sysvmsg"
    "sysvsem"
    "sysvshm"
    "tidy"
    "tokenizer"
    "xml"
    "xmlreader"
    "xmlrpc"
    "xmlwriter"
    "xsl"
    "Zend OPcache"
    "zip"
    "zlib"
    "ssh2"
    "imagick"
  ];
  "files.exclude" = {
    "**/.git" = true;
    "**/.svn" = true;
    "**/.hg" = true;
    "**/CVS" = true;
    "**/.DS_Store" = true;
    "**/Thumbs.db" = true;
    "worktrees/**" = true;
  };
  "update.releaseTrack" = "prerelease";
  # Zen mode
  "zenMode.fullScreen" = false;
  "zenMode.centerLayout" = false;
  "zenMode.showTabs" = "none";
  "zenMode.hideStatusBar" = false;
  "zenMode.hideLineNumbers" = false;
  "workbench.activityBar.location" = "hidden";
  "editor.folding" = false; # to be tight of the line number column
  "editor.semanticHighlighting.enabled" = true;
  "workbench.panel.showLabels" = false;
  "chat.editor.fontFamily" = "'UDEV Gothic 35JPDOC', 'HackGenNerd Console'";
  "semanticdiff.defaultDiffViewer" = true;
  "cursor.composer.shouldAllowCustomModes" = true;
  "[svg]" = {
    "editor.defaultFormatter" = "jock.svg";
  };
  "terminal.integrated.gpuAcceleration" = "auto";
  "workbench.colorTheme" = "Catppuccin Latte";
  "database-client.autoSync" = true;
  "biome.lsp.bin" = null;
  "biome.suggestInstallingGlobally" = false;
  "cursor.cpp.enablePartialAccepts" = true;
  "workbench.editor.showTabs" = "none";
  "github.copilot.nextEditSuggestions.enabled" = true;
    "find-it-faster.general.showMaximizedTerminal" = false;
  "multiCommand.commands" = [
    {
      "command" = "multiCommand.findFiles";
      "interval" = 220;
      "sequence" = [
        "workbench.action.toggleMaximizedPanel"
        "find-it-faster.findFiles"
      ];
    }
    {
      "command" = "multiCommand.findWithinFiles";
      "interval" = 220;
      "sequence" = [
        "workbench.action.toggleMaximizedPanel"
        "find-it-faster.findWithinFiles"
      ];
    }
  ];
  "custom-ui-style.electron" = {
    "frame" = true;
  };
  "custom-ui-style.background.url" = "file:#/Users/k-nanchi/Pictures/Floorp_wallpaper/wall_9.jpeg";
  "custom-ui-style.background.opacity" = 0.92;
  "custom-ui-style.stylesheet" = {
    ".quick-input-widget" = {
      "position" = "absolute !important";
      "top" = "200px !important";
      "left" = "50%";
      "border-radius" = "10px";
      "border" = "1px solid var(--vscode-textSeparator-foreground) !important";
      "box-shadow" = "0 0 60px 0 rgba(0,0,0,0.2) !important";
    };
    # left title bar (controls)
    ".titlebar-left" = {
      "max-width" = "70px !important";
    };
    # center title bar
    ".titlebar-center" = {
      "margin" = "0 !important";
    };
    # whole title bar command center container
    ".action-item.command-center-center" = {
      "background-color" = "transparent !important";
      "border" = "none !important";
      "width" = "fit-content !important";
    };
    # field
    ".quick-input-header" = {
      "padding" = "0 !important";
    };
    # input element containerk
    ".quick-input-header > .quick-input-and-message .monaco-inputbox" = {
      "border-radius" = "10px 10px 0 0 !important";
    };
    # actual input element
    ".quick-input-header > .quick-input-and-message > .quick-input-filter > .quick-input-box input" = {
      "padding" = "8px 10px !important";
    };
    # list of results
    ".quick-input-list > .monaco-list > .monaco-scrollable-element" = {
      "padding" = "2px !important";
    };
    # status bar set height
    "div:has(> .statusbar)" = {
      "height" = "25px !important";
      "top" = "auto !important";
      "bottom" = "0 !important";
    };
    ".statusbar" = {
      "height" = "25px !important";
    };
    # hides search icon
    ".codicon.codicon-search.search-icon" = {
      "display" = "none !important";
    };
    # empty editor background
    ".editor-group-container.empty.active" = {
      "background-color" = "var(--vscode-statusBar-background)";
    };
    "div:has(> .tabs-and-actions-container.tabs-border-bottom.empty)" = {
      "background-color" = "var(--vscode-statusBar-background) !important";
    };
  };
  "animations.Install-Method" = "Custom UI Style";
}
