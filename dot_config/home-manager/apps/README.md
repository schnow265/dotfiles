# App Configurations

This folder contains app defiitions which can be appended to the `modules` array in the home-manager config.

## Example

```nix
"scaletto" = mkHome {
  system = "aarch64-darwin";
  username = "scaletto";
  modules = [
    ./apps/<nix connfig>
  ];
};
```
