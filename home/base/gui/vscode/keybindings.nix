{...}:
  [
    # file explorerにfocusしているとき
    {
      key = "a";
      command = "explorer.newFile";
      when = "filesExplorerFocus && !inputFocus";
    }
    {
      key = "shift+a";
      command = "explorer.newFolder";
      when = "filesExplorerFocus && !inputFocus";
    }
    {
      key = "shift+d";
      command = "deleteFile";
      when = "filesExplorerFocus && !inputFocus";
    }
    {
      key = "r";
      command = "renameFile";
      when = "filesExplorerFocus && !inputFocus";
    }
    {
      key = "y";
      command = "filesExplorer.copy";
      when = "filesExplorerFocus && !inputFocus";
    }
    {
      key = "p";
      command = "filesExplorer.paste";
      when = "filesExplorerFocus && !inputFocus";
    }

    # when filesExploreFocus
    # file treeにfocusしている状態
    # file treeが常に左想定
    #ctrl + l (→)でfileにfocus
    {
      key = "ctrl+l";
      command = "workbench.action.focusActiveEditorGroup";
      when = "filesExplorerFocus";
    }
    # when terminal focus
    # terminalにfocusしている状態
    # terminalが常に下想定
    #ctrl + k (↑)でfileにfocus
    {
      key = "ctrl+k";
      command = "workbench.action.focusActiveEditorGroup";
      when = "terminalFocus";
    }
    # ctrl shift tでterminal内にいるとき新規作成
    {
      key = "ctrl+shift+t";
      command = "workbench.action.terminal.new";
      when = "terminalFocus";
    }
    # ctrl shift wでterminal内にいるとき閉じる
    {
      key = "ctrl+shift+w";
      command = "workbench.action.terminal.kill";
      when = "terminalFocus";
    }
    # ctrl tabでterminal移動
    {
      key = "ctrl+tab";
      command = "workbench.action.terminal.focusNext";
      when = "terminalFocus";
    }
    # ctrl shift tabでterminal逆移動
    {
      key = "ctrl+shift+tab";
      command = "workbench.action.terminal.focusPrevious";
      when = "terminalFocus";
    }
    # ctrl + bでサイドバーを開閉
    {
      key = "ctrl+b";
      command = "workbench.action.toggleSidebarVisibility";
    }
    # ctrl + tでターミナルを開閉
    {
      key = "ctrl+t";
      command = "workbench.action.terminal.toggleTerminal";
    }
    # ctrl+pで検索したパレット内で、ctrl+nで下に移動
    {
      key = "ctrl+n";
      command = "workbench.action.quickOpenNavigateNext";
      when = "inQuickOpen";
    }
    # ctrl+pで検索したパレット内で、ctrl+pで上に移動
    {
      key = "ctrl+p";
      command = "workbench.action.quickOpenNavigatePrevious";
      when = "inQuickOpen";
    }
    # grep検索したあと、検索候補リストにctrl + nで移動
    {
      key = "ctrl+n";
      command = "search.action.focusSearchList";
      when = "searchViewletVisible && searchViewletFocus && inputFocus";
    }
    # grep検索したあと、検索候補リストにいるときに検索ボックスに移動
    {
      key = "ctrl+n";
      command = "workbench.action.findInFiles";
      when = "searchViewletVisible && searchViewletFocus && !inputFocus";
    }
    {
      key = "cmd+i";
      command = "composerMode.agent";
    }
    {
      key = "cmd+l";
      command = "composerMode.chat";
    }
    {
      key = "ctrl+shift+tab";
      command = "workbench.action.previousEditor";
    }
    {
      key = "ctrl+tab";
      command = "workbench.action.nextEditor";
    }
      # Disable the default `enter` submit behaviour for GitHub Copilot chat
      {
          key = "enter";
          command = "-workbench.action.chat.submit";
          when = "inChatInput && (chatInputHasText || chatInstructionsAttached)";
      }
      {
          key = "cmd+enter";
          command = "-workbench.action.chat.submitWithCodebase";
          when = "inChatInput && (chatInputHasText || chatInstructionsAttached)";
      }
      # Setup new bindings for GitHub Copilot chat
      {
          key = "cmd+enter";
          command = "workbench.action.chat.submit";
          when = "inChatInput && (chatInputHasText || chatInstructionsAttached)";
      }
      {
          key = "cmd+shift+enter";
          command = "workbench.action.chat.submitWithCodebase";
          when = "inChatInput && (chatInputHasText || chatInstructionsAttached)";
      }
      {
          key = "enter";
          command = "editor.action.insertLineAfter";
          when = "inChatInput";
      }
  #----------------------------------------------------------
    # 何も開いていない時の設定
    #----------------------------------------------------------
    # ファイル検索
    {
      key = "space f f";
      command = "multiCommand.findFiles";
      when = "!editorFocus && !terminalFocus && !inputFocus";
    }
    # 全体検索
    {
      key = "space f g";
      command = "multiCommand.findWithinFiles";
      when = "!editorFocus && !terminalFocus && !inputFocus";
    }
    # サイドバーを表示
    {
      key = "space e";
      command = "workbench.action.focusSideBar";
      when = "!editorFocus && !terminalFocus && !inputFocus";
    }
    # サイドバーへのフォーカス
    {
      key = "space o";
      command = "workbench.action.focusSideBar";
      when = "!editorFocus && !terminalFocus && !inputFocus";
    }
    # Lazygitの起動
    {
      key = "space g";
      command = "lazygit-vscode.toggle";
      when = "!editorFocus && !terminalFocus && !inputFocus";
    }
  ]
