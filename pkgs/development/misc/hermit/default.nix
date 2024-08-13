{ callPackage }:
rec {
  kernel = callPackage ./kernel.nix {};
}