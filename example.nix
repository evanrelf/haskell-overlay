{
  description = "haskel-overlay example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    # Step 1: Add `haskell-overlay` as a flake input
    haskell-overlay.url = "github:evanrelf/haskell-overlay";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    packages.x86_64-linux =
      import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          # Step 2: Add `haskell-overlay` to Nixpkgs
          inputs.haskell-overlay.overlay

          # Step 3: Use `haskell-overlay` library functions
          (pkgsFinal: pkgsPrev:
            let
              inherit (pkgsPrev) haskell-overlay;
            in
            haskell-overlay.mkOverlay
              {
                # Optionally use a different version of GHC
                # (`pkgs.haskell.compiler.${compiler}`)
                compiler = "ghc921";

                # Optionally use a newer snapshot of Hackage without bumping your
                # Nixpkgs pin
                hackage = {
                  # These correspond to the `hackage` branch of the
                  # `commercialhaskell/all-cabal-hashes` repo
                  rev = "<rev>";
                  sha256 = "<sha256>";
                };

                extensions = [
                  (haskell-overlay.sources {
                    # Add your project to the Haskell package set
                    "your-project" = ./.;

                    # Use a newer version of a library from Hackage
                    "some-library" = "2.0.0.0";
                  })

                  (haskell-overlay.overrideAttrs {
                    # Override attributes
                    "another-library" = prev: {
                      broken = false;
                      doCheck = false;
                    };
                  })
                  # Check out the code for `sources`, `override`,
                  # `overrideCabal`, and `overrideAttrs` for more information.
                ];
              }
              pkgsFinal
              pkgsPrev
          )
        ];
      };
  };
}
