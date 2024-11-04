{ compiler ? "ghc928" }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};

  gitignore = pkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];

  myHaskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = hself: hsuper: {
      "karmaDM" =
        hself.callCabal2nix
          "karmaDM"
          (gitignore ./.)
          {};
    };
  };

  shell = myHaskellPackages.shellFor {
    packages = p: [
      p."karmaDM"
    ];
    buildInputs = [
      myHaskellPackages.haskell-language-server
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.stylish-haskell
      pkgs.haskellPackages.ghcid
      pkgs.haskellPackages.fourmolu
      pkgs.haskellPackages.hlint
      pkgs.niv
      pkgs.nixpkgs-fmt
    ];
    withHoogle = true;
    withHaskellDoc = true;
    withHaddock = true;
  };

  exe = pkgs.haskell.lib.justStaticExecutables (myHaskellPackages."karmaDM");

  docker = pkgs.dockerTools.buildImage {
    name = "karmaDM";
    config.Cmd = [ "${exe}/bin/karmaDM" ];
  };
in
{
  inherit shell;
  inherit exe;
  inherit docker;
  inherit myHaskellPackages;
  "karmaDM" = myHaskellPackages."karmaDM";
}
