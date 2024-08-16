<div align=center>

# python-poetry 🐍

Minimal **Python** development template for **Nix**

</div>

## Usage

- `nix develop`: opens up a `bash` shell with the poetry package
- `nix build` : builds the Python project. Outputs the scripts defined in the `pyproject.toml` to `./result/bin/<name>`
- `nix run`: runs the Python program.


## Reference

1. [wiki/Flakes](https://nixos.wiki/wiki/Flakes)
2. [Poetry](https://python-poetry.org/) - used for python package management
3. [Poetry2Nix](https://github.com/nix-community/poetry2nix) - used to convert poetry projects into nix packages


