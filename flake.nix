{
  description = "ELM with formatting, linting and test";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
      in
      {
        devShell = pkgs.mkShell {
          packages = [
            pkgs.elmPackages.elm
            pkgs.elmPackages.elm-format
            pkgs.elmPackages.elm-review
            pkgs.coreutils # provide `yes` to accept everything asked by `elm-review`
            pkgs.elmPackages.elm-test-rs
            pkgs.elmPackages.elm-test # For the vscode test explorer to work properly
            pkgs.elmPackages.elm-json
            pkgs.nodejs-18_x
            pkgs.yarn
            pkgs.nodePackages.gitmoji-cli
          ];
          
          shellHook = ''
            yarn install
          '';
        };
      });
}
