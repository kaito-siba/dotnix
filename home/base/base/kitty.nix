{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF CN";
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_size = 12;
      window_margin_width = 0;
      window_padding_width = 12;
      enabled_layouts = "splits,stack";
      tab_bar_edge = "bottom";
      tab_bar_style = "separator";
      tab_bar_align = "left";
      tab_separator = "  ";
      active_tab_title_template = "{index} {title}";
      tab_title_template = "{index} {title}";
      tab_bar_filter = "session:~ or session:^$";
    };
    extraConfig = ''
      include ./themes/noctalia.conf

      map ctrl+q>ctrl+q send_key ctrl+q
      map ctrl+q>r load_config_file
      map ctrl+q>p command_palette

      map ctrl+q>c new_tab_with_cwd
      map ctrl+q>x close_tab
      map ctrl+q>shift+, previous_tab
      map ctrl+q>shift+. next_tab
      map ctrl+q>1 goto_tab 1
      map ctrl+q>2 goto_tab 2
      map ctrl+q>3 goto_tab 3
      map ctrl+q>4 goto_tab 4
      map ctrl+q>5 goto_tab 5
      map ctrl+q>6 goto_tab 6
      map ctrl+q>7 goto_tab 7
      map ctrl+q>8 goto_tab 8
      map ctrl+q>9 goto_tab 9

      map ctrl+q>h neighboring_window left
      map ctrl+q>j neighboring_window bottom
      map ctrl+q>k neighboring_window top
      map ctrl+q>l neighboring_window right

      map ctrl+q>- launch --location=hsplit --cwd=current --add-to-session .
      map ctrl+q>_ launch --location=hsplit --cwd=current --add-to-session .
      map ctrl+q>backslash launch --location=vsplit --cwd=current --add-to-session .
      map ctrl+q>| launch --location=vsplit --cwd=current --add-to-session .
      map ctrl+q>% launch --location=vsplit --cwd=current --add-to-session .
      map ctrl+q>" launch --location=hsplit --cwd=current --add-to-session .

      map ctrl+q>[ show_scrollback
      map ctrl+q>/ search_scrollback

      map ctrl+q>s goto_session ~/.local/share/kitty/sessions
      map ctrl+q>shift+s save_as_session --use-foreground-process --base-dir ~/.local/share/kitty/sessions
      map ctrl+q>d close_session .

      map ctrl+q>shift+h resize_window narrower 5
      map ctrl+q>shift+j resize_window shorter 5
      map ctrl+q>shift+k resize_window taller 5
      map ctrl+q>shift+l resize_window wider 5

      map --new-mode resize --on-unknown end ctrl+q>shift+r
      map --mode resize shift+h resize_window narrower 5
      map --mode resize shift+j resize_window shorter 5
      map --mode resize shift+k resize_window taller 5
      map --mode resize shift+l resize_window wider 5
      map --mode resize esc pop_keyboard_mode
      map --mode resize q pop_keyboard_mode
    '';
  };

  home.file.".local/share/kitty/sessions/.keep".text = "";
}
