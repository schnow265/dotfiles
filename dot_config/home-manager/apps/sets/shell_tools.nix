{
  ...
}:
{
  programs.fzf = {
    enable = true;

    enableZshIntegration = true;
    historyWidget.options = [
      "--reverse"
      "--preview 'echo {}'"
      "--preview-window down:3:hidden:wrap"
      "--bind '?:toggle-preview'"
    ];
  };

  programs.bat = {
    enable = true;
  };
}
