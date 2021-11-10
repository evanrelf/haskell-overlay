{
  description = "Helper utilities for overriding Haskell packages in Nixpkgs";

  inputs = { };

  outputs = { self, ... }: {
    lib = import ./default.nix;
    overlay = final: prev: import ./default.nix;
  };
}
