{
  description = "";

  inputs = { };

  outputs = { self, ... }: {
    lib = import ./default.nix;
    overlay = final: prev: import ./default.nix;
  };
}
