# shell.nix
{ pkgs ? import <nixpkgs> {} }:
(pkgs.stdenv.mkDerivation {
  name = "work-shell";
  buildInputs = with pkgs; [
    libgcc
    stdenv.cc.cc
    binutils
    coreutils
    python311Full
    poetry
    ngrok
    redis
    yarn
    google-cloud-sdk
    vscode

    (writeShellScriptBin "start-ngrok" ''
      ngrok http 8080
    '')
    (writeShellScriptBin "start-ui" ''
      yarn --cwd ${HOME}/projects/company-name/streetb-beat-aikit-web start
    '')
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [pkgs.stdenv.cc.cc]}
  '';
})
