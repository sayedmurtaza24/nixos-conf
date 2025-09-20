{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      font-family = "Operator Mono";
      font-style = "Book";
      font-style-italic = "Book Italic";
      font-style-bold = "Medium";
      font-style-bold-italic = "Medium Italic";
      adjust-cell-height = 2;
      adjust-font-baseline = 1;
      adjust-cursor-height = 2;

      font-thicken = true;
      font-thicken-strength = 1;
      alpha-blending = "native";

      font-size = 14;

      theme = "Kanagawa Dragon";
      minimum-contrast = 1;
      cursor-style = "block";

      cursor-click-to-move = true;
      background-opacity = 0.80;
      background-blur-radius = 60;
      unfocused-split-opacity = 0.7;

      scrollback-limit = 10000000;
      link-url = true;
      fullscreen = false;

      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      window-padding-color = "background";
      window-vsync = true;
      window-inherit-working-directory = true;
      window-inherit-font-size = false;
      window-decoration = true;
    };
  };
}
