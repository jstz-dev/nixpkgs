{ stdenv, texinfo, flex, bison, crossLibcStdenv, buildPackages, fetchFromGitHub, hermit-os }:

crossLibcStdenv.mkDerivation {
  name = "newlib";
  src = fetchFromGitHub {
    owner = "jstz-dev";
    repo = "hermit-newlib";
    rev = "refs/heads/releases/newlib-4.3.0";
    sha256 = "sha256-449cWwDRO8TkBzSP2xoLCPvXYSiJPfcUa/u2RZxkbdI=";
  };
  
  dontUpdateAutotoolsGnuConfigScripts = true;
  enableParallelBuilding = true;

  nativeBuildInputs = [ texinfo flex bison ];
  depsBuildBuild = [ buildPackages.stdenv.cc ];

  env.NIX_CFLAGS_COMPILE = "-fPIC -fpermissive";
  # newlib expects CC to build for build platform, not host platform
  preConfigure = ''
    export CC=cc
  '';

  dontStrip = true;

  configurePlatforms = [ "build" "target" ];
  configureFlags = [
    "--with-newlib"
    "--host=${stdenv.targetPlatform.config}"
  ];

  passthru = {
    incdir = "/${stdenv.targetPlatform.config}/include";
    libdir = "/${stdenv.targetPlatform.config}/lib";
  };
}
