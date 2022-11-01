{
  description = "Helper utilities for overriding Haskell packages in Nixpkgs";

  inputs = { };

  outputs = { self, ... }: {
    lib = import ./default.nix;
    overlays.default = final: prev: { haskell-overlay = self.lib; };
    overlay = self.overlays.default;
  };
}
