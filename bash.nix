{
  programs.bash = {
    enable = true;
    historySize = 50000;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    shellOptions = ["histappend" "cmdhist" "autocd" "cdspell"];
    bashrcExtra = ''
      # Enable history search with up/down arrows
      bind -m vi-insert '"\C-p": history-search-backward'
      bind -m vi-insert '"\C-n": history-search-forward'

      # Yank (paste) in insert mode
      bind -m vi-insert '"\C-y": yank'

      # Color for grep
      export GREP_OPTIONS='--color=auto'
      # LS colors
      export CLICOLOR=1
      export LSCOLORS=GxFxCxDxBxegedabagaced

      # Case-insensitive completion
      bind "set completion-ignore-case on"
      # Show all completions immediately
      bind "set show-all-if-ambiguous on"

      # Enable vim mode
      set -o vi
    '';
    shellAliases = {
      conf = "sudo -E nvim -c 'cd /etc/nixos/' -c ':Telescope find_files theme=get_ivy'";
      lgit = "lazygit";
      nrs = "sudo nixos-rebuild switch";
      cd = "z";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "powerline";
  };
}
