{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    tmuxinator
  ];

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
