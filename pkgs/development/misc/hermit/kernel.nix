# Thie derivation is used to install a prebuilt version of the Hermit kernel

{ stdenv, buildPackages}:
buildPackages.stdenv.mkDerivation rec {
  name = "hermit-kernel-bootstrap";

  src = ./boot/${stdenv.targetPlatform.parsed.cpu.name};

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/lib
    cp $src/libhermit.a $out/lib/libhermit.a
  '';
}