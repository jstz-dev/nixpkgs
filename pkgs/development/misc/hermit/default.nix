{ callPackage }:
rec {
  kernel = callPackage ./kernel.nix {};

  newlib = callPackage ./newlib.nix {};
}