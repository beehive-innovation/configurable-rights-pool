let
 pkgs = import <nixpkgs> {};

 prepack = pkgs.writeShellScriptBin "prepack" ''
 npm run compile

 rm -rf artifacts
 mkdir -p artifacts
 cp build/contracts/*.json artifacts
 '';

 publish = pkgs.writeShellScriptBin "publish" ''
 npm pack
 npm publish ./configurable-rights-pool-0.0.2.tgz --access public
 '';
in
pkgs.stdenv.mkDerivation {
 name = "shell";
 buildInputs = [
  pkgs.nodejs-14_x
  prepack
  publish
 ];

 shellHook = ''
  export PATH=$( npm bin ):$PATH
  # keep it fresh
  npm install
 '';
}