let
  pkgs = import <nixpkgs> { };

  prepack = pkgs.writeShellScriptBin "prepack" ''
    npm run compile

    rm -rf artifacts
    mkdir -p artifacts
    cp build/contracts/*.json artifacts
  '';
in
pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = [
    pkgs.nixpkgs-fmt
    pkgs.nodejs-14_x
    prepack
  ];

  shellHook = ''
    export PATH=$( npm bin ):$PATH
    # keep it fresh
    npm install
  '';
}
