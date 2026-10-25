{
  config,
  ...
}:
{
  programs.zk = {
    enable = true;
    settings = {
      note = {
        default-title = "Untitled";
        extension = "md";
        filename = "{{id}}-{{slug title}}-{{format-date now '%Y-%m-%d'}}";
        id-case = "lower";
        id-charset = "alphanum";
        id-length = 4;
      };
      notebook.dir = "${config.home.homeDirectory}/zk/";
    };
    exportNotebookDir = true;
  };
}
