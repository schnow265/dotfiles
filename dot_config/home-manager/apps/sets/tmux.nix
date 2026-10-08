{
  pkgs,
  ...
}:
let
  tmuxinator_completions = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/tmuxinator/tmuxinator/ea4a41b22b9ced27ce23742d758fd8d3c0b7ac9b/completion/tmuxinator.zsh";
    hash = "sha256-NUR0CQz43yC6vMOzq4cSCEtqCP7GQj8urR4PASZhJBA=";
  };
in
{
  home.packages = with pkgs; [
    tmuxinator
  ];

  home.file.".local/share/external/zsh/completions/_tmuxinator".source = tmuxinator_completions;

  programs.tmux = {
    enable = true;

    mouse = true;
    baseIndex = 1;
    paneBaseIndex = 1;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      session-wizard
      tmux-which-key
      tmux-powerline
    ];

    extraConfig = ''
      set -g extended-keys on
      set -g extended-keys-format csi-u

      set -g status on
      set -g status-justify left
      set -g status-left ""
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-interval 2
    '';
  };
}
