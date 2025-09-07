{ config, pkgs, lib, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        font = "Operator Mono Book:size=14";
        font-bold = "Operator Mono Medium:size=14";
        font-italic = "Operator Mono Book:size=14";
        selection-target="clipboard";
      };

      colors = {
        alpha = 0.8;

        foreground = "dcd7ba";
        background = "151515";

        selection-foreground = "c8c093";
        selection-background = "2d4f67";

        regular0 = "090618";
        regular1 = "c34043";
        regular2 = "76946a";
        regular3 = "c0a36e";
        regular4 = "7e9cd8";
        regular5 = "957fb8";
        regular6 = "6a9589";
        regular7 = "c8c093";

        bright0  = "727169";
        bright1  = "e82424";
        bright2  = "98bb6c";
        bright3  = "e6c384";
        bright4  = "7fb4ca";
        bright5  = "938aa9";
        bright6  = "7aa89f";
        bright7  = "dcd7ba";

        "16"       = "ffa066";
        "17"       = "ff5d62";
      };

      scrollback = {
        lines = 10000;
      };

      cursor = {
        blink = "yes";
      };
    };
  };
}
