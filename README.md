# Homebrew tap for pytermwm

[pytermwm](https://github.com/pez2001/pytermwm) is a terminal window manager in pure Python: tiled, floating and
docked windows, desktops, themes, a status line with a prompt, driven by the keyboard, a CLI, HTTP and MCP.

```
brew install pez2001/pytermwm/pytermwm
pytermwm            # attach to (or create) the default session
pytermwm doctor     # check that this machine can run everything
```

Update with `brew upgrade pytermwm`. Works on macOS and Linux (Homebrew on Linux). Without Homebrew:
`pipx install pytermwm` or `pip install pytermwm`.

## Updating the formula for a new release

1. Take the new sdist's URL and SHA-256 from https://pypi.org/project/pytermwm/#files.
2. Put them into `url` and `sha256` in [Formula/pytermwm.rb](Formula/pytermwm.rb) (and bump the PyYAML resource if
   needed: `brew update-python-resources pytermwm`).
3. Open a pull request: CI installs the formula and runs its test on macOS and Linux.
