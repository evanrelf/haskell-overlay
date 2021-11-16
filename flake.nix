{
  description = "Helper utilities for overriding Haskell packages in Nixpkgs";

  inputs = { };

  outputs = { self, ... }: {
    lib = import ./default.nix;
    overlay = final: prev: { haskell-overlay = import ./default.nix; };
  };
}
