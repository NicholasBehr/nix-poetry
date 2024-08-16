{
  description = "Poetry python application";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    poetry2nix,
    ...
  }:
    utils.lib.eachDefaultSystem (system: 
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          poetry2nix.overlays.default
        ];
      };

      python = pkgs.python3;
      projectDir = ./.;

      localCI = pkgs.writeScriptBin "qa" ''
      set -e

      echo "1. check static typing ..."
      mypy --strict package tests

      echo "2. check formatting ..."
      pylint package tests

      echo "3. run unit tests ..."
      pytest -s --doctest-modules --no-header

      echo ">> PASSED <<"
      '';
    in {
      packages.default = pkgs.poetry2nix.mkPoetryApplication {
        inherit python projectDir;
        # Non-Python runtime dependencies go here
        propogatedBuildInputs = [];
      };

      devShell = pkgs.mkShell {
        buildInputs = [
          (pkgs.poetry2nix.mkPoetryEnv {
            inherit python projectDir;
          })
          pkgs.poetry
          localCI
        ] ++ (with python.pkgs; [
          black
          mypy
          pylint
          pytest
        ]);
        shellHook = ''
          export MYPYPATH=$PW
        '';
      };
    });
}
