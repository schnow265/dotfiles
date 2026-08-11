# schnow265/nvim.conf

My extremey bad nvim config for my purposes.

## Avaliable confis

This repo has some "playgounds" for some of the more experimental frameworks.

| Branch | Base Framework | URL | Comment | 
| --- | --- | --- | --- |
| `master` | kickstart.nvim | <https://github.com/nvim-lua/kickstart.nvim> | Default. |
| `minimax` | MiniMax | <https://github.com/nvim-mini/MiniMax> | Only initialized, not really used |
| `rocks.nvim` | rocks.nvim | <https://github.com/lumen-oss/rocks.nvim> | Seems interesting |
| `NvChad` | NvChad | <https://nvchad.com> | Exists for some readon in the repo. |

## Usage

Add to `.chezmoiexternal.toml`:

```toml
[".config/nvim"]
type = "git-repo"
url = "https://gitlab.com/schnow265/nvim.conf.git"
refreshPeriod = "24h"
```

... and then run `chezmoi apply`

## NOTE: This Repository has moved to GitLab

GitHub is being used as a mirror which might fer out of sync *really* fast...

[Just got to GitLab.](https://gitlab.com/schnow265/nvim.conf.git)
