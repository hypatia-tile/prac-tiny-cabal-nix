{
  description = "Tiny Cabal package built by Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgsFor = system:
      import nixpkgs {
        inherit system;
      };
  in {
    packages = forAllSystems (
      system: let
        pkgs = pkgsFor system;
        hpkgs = pkgs.haskellPackages;
      in {
        default = hpkgs.callCabal2nix "tiny-cabal-nix" ./. {};
      }
    );

    apps = forAllSystems (system: let
      pkg = self.packages.${system}.default;
    in {
      default = {
        type = "app";
        program = "${pkg}/bin/tiny-cabal-nix";
      };
    });

    devShells = forAllSystems (system: let
      pkgs = pkgsFor system;
      hpkgs = pkgs.haskellPackages;
    in {
      default = hpkgs.shellFor {
        packages = p: [
          self.packages.${system}.default
        ];

        nativeBuildInputs = [
          hpkgs.ghc
          hpkgs.hoogle
          hpkgs.fast-tags
          pkgs.cabal-install
          pkgs.haskell-language-server
          pkgs.fourmolu
        ];
      };
    });
  };
}
